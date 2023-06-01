require_relative 'genre'
require_relative 'music_album'
require_relative 'book'
require_relative 'label'
require_relative 'game'
require_relative 'author'
require 'json'

class App
  def initialize
    @genres = []
    @labels = load_data('labels.json')
    @music_albums = []
    @books = load_data('books.json')
    @authors = []
    @games = []

    load_genres_data
    load_music_albums_data
    load_authors_data
    load_games_data
  end

  def load_file(file_path)
    return [] unless File.exist?(file_path) && File.size(file_path).positive?

    JSON.load_file(file_path)
  end

  def load_data(file_name)
    file_path = File.join('data', file_name)
    data = load_file(file_path)
    helper_data = { labels: @labels }
    data.map { |elem| Object.const_get(elem['type']).from_parsed_json(elem, helper_data) }
  end

  def load_music_albums_data
    music_albums_data = load_file('./data/music_albums.json')

    music_albums_data.each do |music_album_data|
      new_music_album = MusicAlbum.new(music_album_data['on_spotify'], music_album_data['publish_date'],
                                       music_album_data['archived'], music_album_data['title'])

      new_music_album.genre = @genres.find { |genre| genre.name == music_album_data['genre'] }
      @music_albums << new_music_album
    end
  end

  def load_genres_data
    genres_data = load_file('./data/genres.json')

    genres_data.each do |genre_data|
      new_genre = Genre.new(genre_data['name']) unless @genres.include?(genre_data['name'])
      @genres << new_genre
    end
  end

  def load_games_data
    games_data = load_file('./data/games.json')

    games_data.each do |game_data|
      new_game = Game.new(game_data['multiplayer'], game_data['last_played_at'], game_data['publish_date'],
                          game_data['archived'], game_data['title'])

      new_game.author = @authors.find do |author|
        author_first_name, author_last_name = game_data['author'].split(' ')
        author.first_name == author_first_name && author.last_name == author_last_name
      end
      @games << new_game
    end
  end

  def load_authors_data
    authors_data = load_file('./data/authors.json')
    authors_data.each do |author_data|
      new_author = Author.new(author_data['first_name'], author_data['last_name'])
      @authors << new_author
    end
  end

  def list_books
    if @books.empty?
      puts '', 'There are no books', ''
    else
      puts '', @books, ''
    end
  end

  def list_music_albums
    if @music_albums.empty?
      puts("\n- There are no music albums -")
      return
    end

    puts 'Music albums:'
    @music_albums.each_with_index do |music_album, index|
      puts "#{index + 1}. Title: #{music_album.title} | Publish date: #{music_album.publish_date} |" \
           "Archived: #{music_album.archived} | On Spotify: #{music_album.on_spotify} | " \
           "Genre: #{music_album.genre.name}"
    end
  end

  def list_games
    if @games.empty?
      puts("\n- There are no games -")
      return
    end

    puts 'Games:'
    @games.each_with_index do |game, index|
      puts "#{index + 1}. Title: #{game.title} | Publish date: #{game.publish_date} | " \
           "Archived: #{game.archived} | Multiplayer: #{game.multiplayer} | " \
           "Last played: #{game.last_played_at} | Author: #{game.author.first_name} #{game.author.last_name}"
    end
  end

  def list_genres
    @genres.empty? && puts("\n- There are no genres -")

    puts 'Genres:'
    @genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_labels
    if @labels.empty?
      puts '', 'There are no labels', ''
    else
      puts('', @labels, '')
    end
  end

  def list_authors
    @authors.empty? && puts("\n- There are no authors -")
    puts 'Authors:'
    @authors.each_with_index do |author, index|
      puts "#{index + 1}. #{author.first_name} #{author.last_name}"
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Publisher: '
    publisher = gets.chomp
    print 'Publish date (YYYY/MM/DD): '
    publish_date = Date.new(*gets.chomp.split('/').map(&:to_i))
    print 'Cover state [good/bad]: '
    cover_state = gets.chomp
    print 'Is it archived? [Y/N]: '
    archived = gets.chomp.match?(/^[yY]$/)
    puts 'Please select a label:'
    list_labels
    label_id = gets.chomp.to_i
    relevant_label = @labels.find { |label| label.id == label_id }

    new_book = Book.new(publish_date: publish_date, archived: archived, publisher: publisher, cover_state: cover_state,
                        title: title)
    new_book.label = relevant_label
    @books << new_book
  end

  def create_music_album
    # Ask the user for the publish date, on spotify, archived and genre of the music album
    print "\nPlease enter the title of the album: "
    title = gets.chomp
    print 'Please enter the publish date of the album (YYYY/MM/DD): '
    publish_date = Date.new(*gets.chomp.split('/').map(&:to_i))
    print 'Is the album on Spotify? (y/n): '
    on_spotify = gets.chomp == 'y'
    print 'Is the album archived? (y/n): '
    archived = gets.chomp == 'y'
    puts 'Please select a genre: '
    list_genres
    genre_index = gets.chomp.to_i - 1

    # Create a new music album and add it to the list of music albums
    new_music_album = MusicAlbum.new(on_spotify, publish_date, archived, title)
    new_music_album.genre = @genres[genre_index]
    @music_albums << new_music_album

    # Print a message to the user saying that the music album was created successfully
    puts "\nThe music album was created successfully"
  end

  def create_game
    print "\nTitle: "
    title = gets.chomp
    print 'Publish date (YYYY/MM/DD): '
    publish_date = Date.new(*gets.chomp.split('/').map(&:to_i))
    print 'Is it archived? (y/n): '
    archived = gets.chomp == 'y'
    print 'Is it multiplayer? (y/n): '
    multiplayer = gets.chomp == 'y'
    print 'Last played at (YYYY/MM/DD): '
    last_played_at = Date.new(*gets.chomp.split('/').map(&:to_i))
    puts 'Please select an author: '
    list_authors
    author_index = gets.chomp.to_i - 1

    new_game = Game.new(multiplayer, last_played_at, publish_date, archived, title)
    new_game.author = @authors[author_index]
    @games << new_game

    puts "\nThe game was created successfully"
  end

  def exit
    # Save the music albums to a file
    music_albums_data = @music_albums.map do |music_album|
      { on_spotify: music_album.on_spotify, publish_date: music_album.publish_date, archived: music_album.archived,
        title: music_album.title, genre: music_album.genre.name }
    end

    File.write('./data/music_albums.json', JSON.generate(music_albums_data))

    # Save the genres to a file
    genres_data = @genres.map do |genre|
      { name: genre.name }
    end

    File.write('./data/genres.json', JSON.generate(genres_data))

    # Save the games to a file
    games_data = @games.map do |game|
      { multiplayer: game.multiplayer, last_played_at: game.last_played_at, publish_date: game.publish_date,
        archived: game.archived, title: game.title, author: "#{game.author.first_name} #{game.author.last_name}" }
    end

    File.write('./data/games.json', JSON.generate(games_data))

    # Save the authors to a file
    authors_data = @authors.map do |author|
      { first_name: author.first_name, last_name: author.last_name }
    end
    File.write('./data/authors.json', JSON.generate(authors_data))

    # Save all books to a file
    File.write('data/books.json', @books.to_json)
  end
end
