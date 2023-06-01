require_relative '../author'

describe Author do
  before(:each) do
    @author = Author.new('First', 'Last')
    @item = Item.new
  end

  describe '#initialize' do
    it 'creates a new instance of Author' do
      expect(@author).to be_an_instance_of(Author)
    end

    it 'should have attributes' do
      expect(@author).to have_attributes(first_name: 'First', last_name: 'Last')
    end
  end

  describe '#add_item' do
    before(:each) do
      @author.add_item(@item)
    end

    it 'adds an item to the author items collection' do
      expect(@author.items).to include(@item)
    end

    it 'does not add an item to the author if it is already there' do
      @author.add_item(@item)
      expect(@author.items).to eq([@item])
    end

    it 'sets the author of the item instance' do
      expect(@item.author).to eq(@author)
    end
  end
end
