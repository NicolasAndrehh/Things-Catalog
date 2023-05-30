require_relative '../label'
require_relative '../item'

describe Label do
  before(:all) do
    @label_data = { id: rand(1000), title: 'Gift', color: 'blue' }
  end

  before(:each) do
    @label = Label.new(id: @label_data[:id], title: @label_data[:title], color: @label_data[:color])
  end

  context '#initialize' do
    it 'should initialize with the given title, color, and empty items array' do
      expect(@label).to be_an_instance_of(Label)
      expect(@label).to have_attributes(
        id: @label_data[:id],
        title: @label_data[:title],
        color: @label_data[:color],
        items: []
      )
    end
  end

  context '#add_item' do
    before(:each) do
      @prev_label = Label.new
      @item = Item.new
      @prev_label.add_item(@item)
    end

    context 'when adding an item to a single label' do
      it 'should add item to items array' do
        expect(@prev_label).to have_attributes(items: [@item])
      end

      it "should set label to item's label" do
        expect(@item).to have_attributes(label: @prev_label)
      end
    end

    context 'when adding the same item to different labels' do
      before(:each) do
        @label.add_item(@item)
      end

      it "should remove the item from prev_label's items" do
        expect(@prev_label).to have_attributes(items: [])
        expect(@label).to have_attributes(items: [@item])
      end

      it "should overwrite item's label" do
        expect(@item).not_to have_attributes(label: @prev_label)
        expect(@item).to have_attributes(label: @label)
      end
    end
  end
end
