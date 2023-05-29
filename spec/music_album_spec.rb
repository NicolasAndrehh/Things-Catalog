require_relative '../music_album'

describe MusicAlbum do
    describe "#can_be_archived?" do
        it "returns true if the album is on spotify and can be archived" do
            album = MusicAlbum.new(true, 11, false)
            expect(album.can_be_archived?).to eq(true)
        end

        it "returns false if the album is not on spotify" do
            album = MusicAlbum.new(false, 11, false)
            expect(album.can_be_archived?).to eq(false)
        end

        it "returns false if the album cannot be archived" do
            album = MusicAlbum.new(true, 9, false)
            expect(album.can_be_archived?).to eq(false)
        end
    end
end