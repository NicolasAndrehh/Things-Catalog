require_relative 'item.rb'

class MusicAlbum < Item

    def initialize (on_spotify, publish_date, archived)
        super(publish_date, archived)
        @on_spotify = on_spotify
    end

    def can_be_archived?
        super && @on_spotify
    end
end