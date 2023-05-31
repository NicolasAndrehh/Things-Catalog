require_relative '../genre'
require_relative '../item'

describe Genre do
  before(:each) do
    @genre = Genre.new('Rock')
    @item = Item.new
  end

  describe '#initialize' do
    it 'creates a new instance of Genre' do
      expect(@genre).to be_an_instance_of(Genre)
    end

    it 'should have attributes' do
      expect(@genre).to have_attributes(name: 'Rock', items: [])
    end
  end

  describe '#add_item' do
    before(:each) do
      @genre.add_item(@item)
    end

    it 'adds an item to the genre items collection' do
      expect(@genre.items).to include(@item)
    end

    it 'does not add an item to the genre if it is already there' do
      @genre.add_item(@item)
      expect(@genre.items).to eq([@item])
    end

    it 'sets the genre of the item instance' do
      expect(@item.genre).to eq(@genre)
    end
  end
end
