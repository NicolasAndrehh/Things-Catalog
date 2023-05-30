require_relative 'genre.rb'
require_relative 'music_album.rb'

class App

  def initialize
    @music_albums = []
    @genres = []
  end

  def list_books; end
  
  def list_music_albums
    @music_albums.empty? && puts("\n- There are no music albums -")

    @music_albums.each_with_index do |music_album, index|
      puts "#{index + 1}. On Spotify: #{music_album.on_spotify} Publish date: #{music_album.publish_date} Archived: #{music_album.archived}"
    end
  end

  def list_games; end
  
  def list_genres
    @genres.empty? && puts("\n- There are no genres -")

    @genres.each_with_index do |genre, index|
      puts "\n#{index + 1}. #{genre.name}"
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
    puts "\nThe music album was created successfully\n"
  end

  def create_game; end
  def exit; end
end
