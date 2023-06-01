require_relative '../item'
require_relative '../author'
require_relative '../label'
require_relative '../genre'

describe Item do
  before(:each) do
    @item = Item.new(id: 1, publish_date: Date.new(2010, 1, 1), archived: false, title: 'Sample Item')
    @genre = Genre.new('Rock')
    @author = Author.new('Rashed', 'Arman')
    @label = Label.new
  end

  describe '#initialize' do
    it 'creates a new instance of Item' do
      expect(@item).to be_an_instance_of(Item)
    end

    it 'should have attributes' do
      expect(@item).to have_attributes(id: 1, publish_date: Date.new(2010, 1, 1), archived: false, title: 'Sample Item')
    end
  end

  describe '#genre=' do
    before(:each) do
      @item.genre = @genre
    end

    it 'sets the genre of the item instance' do
      expect(@item.genre).to eq(@genre)
    end

    it 'adds the item to the genre items collection' do
      expect(@genre.items).to include(@item)
    end

    it 'removes the item from the previous genre items collection' do
      previous_genre = Genre.new('Pop')
      @item.genre = previous_genre
      expect(@genre.items).not_to include(@item)
      expect(previous_genre.items).to include(@item)
    end
  end

  describe '#author=' do
    before(:each) do
      @item.author = @author
    end

    it 'sets the author of the item instance' do
      expect(@item.author).to eq(@author)
    end

    it 'adds the item to the author items collection' do
      expect(@author.items).to include(@item)
    end

    it 'removes the item from the previous author items collection' do
      next_author = Author.new('Dico', 'Diaz')
      @item.author = next_author
      expect(@author.items).not_to include(@item)
      expect(next_author.items).to include(@item)
    end
  end

  describe '#label=' do
    before(:each) do
      @item.label = @label
    end

    it 'sets the label of the item instance' do
      expect(@item.label).to eq(@label)
    end

    it 'adds the item to the label items collection' do
      expect(@label.items).to include(@item)
    end

    it 'removes the item from the previous label items collection' do
      next_label = Label.new
      @item.label = next_label
      expect(@label.items).not_to include(@item)
      expect(next_label.items).to include(@item)
    end
  end

  describe '#move_to_archive' do
    it 'archives the item if it can be archived' do
      @item.move_to_archive
      expect(@item.archived).to be true
    end

    it 'does not archive the item if it cannot be archived' do
      future_item = Item.new(id: 2, publish_date: Date.new(2024, 1, 1), archived: false, title: 'Future Item')
      future_item.move_to_archive
      expect(future_item.archived).to be false
    end
  end
end
