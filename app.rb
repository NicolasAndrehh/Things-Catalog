require_relative 'genre'
require_relative 'music_album'
require 'json'

class App
  def initialize
    @music_albums = []
    @genres = []
  end

  def load_data
    # Load the music albums from a file
    music_albums_data = File.read('./data/music_albums.json') if File.exist?('./data/music_albums.json')

    # If the data is empty, set the music albums to an empty array
    if music_albums_data.nil? || music_albums_data.empty?
      music_albums_data = []
    else
      music_albums_data = JSON.parse(File.read('./data/music_albums.json'))
    end

    # Preserve the music albums in the app
    music_albums_data.each do |music_album_data|
      new_music_album = MusicAlbum.new(music_album_data['on_spotify'], music_album_data['publish_date'], music_album_data['archived'])
      @music_albums << new_music_album
    end

    # Load the genres from a file
    genres_data = File.read('./data/genres.json') if File.exist?('./data/genres.json')

    # If the data is empty, set the genres to an empty array
    if genres_data.nil? || genres_data.empty? 
      genres_data = []
    else
      genres_data =  JSON.parse(File.read('./data/genres.json'))
    end

    # Preserve the genres in the app
    genres_data.each do |genre_data|
      new_genre = Genre.new(genre_data['name'])
      @genres << new_genre
    end
  end
  
  def list_books; end

  def list_music_albums
    @music_albums.empty? && puts("\n- There are no music albums -")

    @music_albums.each_with_index do |music_album, index|
      puts "#{index + 1}. #{music_album.on_spotify} | #{music_album.publish_date} | #{music_album.archived}"
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
    new_music_album = MusicAlbum.new(on_spotify, publish_date, archived)
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
      { on_spotify: music_album.on_spotify, publish_date: music_album.publish_date, archived: music_album.archived}
    end
    
    File.write('./data/music_albums.json', JSON.generate(music_albums_data))

    # Save the genres to a file
    genres_data = @genres.map do |genre|
      { name: genre.name }
    end
  
    File.write('./data/genres.json', JSON.generate(genres_data))
  end
end
