require_relative 'genre'
require_relative 'music_album'
require 'json'

class App
  def initialize
    @music_albums = []
    @genres = []
  end

  def load_data
    load_music_albums_data
    load_genres_data
  end

  def load_file(file_path)
    return [] unless File.exist?(file_path) && File.size(file_path).positive?

    JSON.parse(File.read(file_path))
  end

  def load_music_albums_data
    music_albums_data = load_file('./data/music_albums.json')

    music_albums_data.each do |music_album_data|
      new_music_album = MusicAlbum.new(music_album_data['on_spotify'], music_album_data['publish_date'],
                                       music_album_data['archived'], music_album_data['title'])
                                             
      new_music_album.genre = Genre.new(music_album_data['genre']) unless @genres.include?(music_album_data['genre'])
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

  def list_books; end

  def list_music_albums
    @music_albums.empty? && puts("\n- There are no music albums -")

    @music_albums.each_with_index do |music_album, index|
      puts "#{index + 1}. Title: #{music_album.title} | Publish date: #{music_album.publish_date} |" +
        "Archived: #{music_album.archived} | On Spotify: #{music_album.on_spotify} | " +
        "Genre: #{music_album.genre.name}"
    end
  end

  def list_games; end

  def list_genres
    @genres.empty? && puts("\n- There are no genres -")

    @genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_labels; end
  def list_authors; end
  def create_book; end

  def create_music_album
    # Ask the user for the publish date, on spotify, archived and genre of the music album
    print "\nPlease enter the title of the album: "
    title = gets.chomp
    print "\nPlease enter the publish date of the album:"
    publish_date = gets.chomp
    print 'Is the album on Spotify? (y/n): '
    on_spotify = gets.chomp == 'y'
    print 'Is the album archived? (y/n): '
    archived = gets.chomp == 'y'
    print 'Please enter the genre of the album: '
    genre = gets.chomp

    # Create a new music album and add it to the list of music albums
    new_genre = Genre.new(genre)
    new_music_album = MusicAlbum.new(on_spotify, publish_date, archived, title)
    new_music_album.genre = new_genre
    @music_albums << new_music_album
    @genres << new_genre

    # Print a message to the user saying that the music album was created successfully
    puts "\nThe music album was created successfully"
  end

  def create_game; end

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
  end
end
