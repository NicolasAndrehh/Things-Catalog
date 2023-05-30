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
end
