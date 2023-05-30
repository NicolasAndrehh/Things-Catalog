require_relative '../book'
require_relative '../item'
require 'date'

describe Book do
  before(:all) do
    @book_data = { id: rand(1000), publish_date: Date.new(2023, 5, 29), archived: false, title: 'Dune',
                   publisher: 'Hachette', cover_state: 'good' }
  end

  before(:each) do
    @book = Book.new(id: @book_data[:id], publish_date: @book_data[:publish_date], archived: @book_data[:archived],
                     title: @book_data[:title], publisher: @book_data[:publisher],
                     cover_state: @book_data[:cover_state])
  end

  context 'inheritance' do
    it 'should be a subclass of Item' do
      expect(Book.superclass).to be(Item)
    end
  end

  context '#initialize' do
    it 'should initialize with the given publish_date, archived, publisher, and cover_state' do
      expect(@book).to be_an_instance_of(Book)
      expect(@book).to have_attributes(
        id: @book_data[:id],
        publish_date: @book_data[:publish_date],
        archived: @book_data[:archived],
        title: @book_data[:title],
        publisher: @book_data[:publisher],
        cover_state: @book_data[:cover_state]
      )
    end
  end

  context '#move_to_archive' do
    it "should not set archived to true when publish_date is not older than 10 years and cover_state is not 'bad'" do
      @book.move_to_archive
      expect(@book).to have_attributes(archived: false)
    end

    it 'should set archived to true when publish_date is older than 10 years' do
      @book.publish_date = Date.new(2012, 5, 29)
      @book.move_to_archive
      expect(@book).to have_attributes(archived: true)
    end

    it "should set archived to true when cover_state is 'bad'" do
      @book.cover_state = 'bad'
      @book.move_to_archive
      expect(@book).to have_attributes(archived: true)
    end

    it "should set archived to true when publish_date is older than 10 years and cover_state is 'bad'" do
      @book.publish_date = Date.new(2012, 5, 29)
      @book.cover_state = 'bad'
      @book.move_to_archive
      expect(@book).to have_attributes(archived: true)
    end
  end
end
