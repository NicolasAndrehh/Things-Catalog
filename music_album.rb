require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(on_spotify, publish_date, archived, title)
    super(publish_date: publish_date, archived: archived, title: title)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end

  def self.from_parsed_json(music_album, helper_data)
    new_music_album = new(music_album['on_spotify'], music_album['publish_date'],
                          music_album['archived'], music_album['title'])
    new_music_album.genre = helper_data[:genres].find { |genre| genre.name == music_album['genre'] }
    new_music_album
  end
end
