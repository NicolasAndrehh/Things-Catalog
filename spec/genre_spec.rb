require_relative '../genre'
require_relative '../item'

describe Genre do
  before(:each) do
    @genre = Genre.new('Rock')
    @item = Item.new(11, false, 'Title')
  end

  describe '#add_item' do
    it 'adds an item to the genre items collection' do
      @genre.add_item(@item)
      expect(@genre.items).to include(@item)
    end

    it 'does not add an item to the genre if it is already there' do
      @genre.add_item(@item)
      @genre.add_item(@item)
      expect(@genre.items).to eq([@item])
    end

    it 'sets the genre of the item instance' do
      @genre.add_item(@item)
      expect(@item.genre).to eq(@genre)
    end
  end
end
