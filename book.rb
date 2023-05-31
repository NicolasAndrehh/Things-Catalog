require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(args)
    super(id: args[:id], publish_date: args[:publish_date], archived: args[:archived], title: args[:title])
    @publisher = args[:publisher]
    @cover_state = args[:cover_state]
  end

  def to_s
    "#{@id}. Title: #{@title}, Publisher: #{@publisher}, Publish date: #{@publish_date}, " \
      "Cover state: #{@cover_state}, Archived: #{@archived}, Label title: #{@label.title}, " \
      "Label color: #{@label.color}"
  end

  def to_json(*args)
    {
      type: self.class,
      id: @id,
      title: @title,
      publish_date: @publish_date,
      archived: @archived,
      publisher: @publisher,
      cover_state: @cover_state,
      label_id: @label.id
    }.to_json(*args)
  end

  def self.from_parsed_json(book, helper_data)
    relevant_label = helper_data[:labels].find { |label| label.id == book['label_id'] }
    new_book = new(id: book['id'], title: book['title'], publish_date: book['publish_date'], archived: book['archived'],
                   publisher: book['publisher'], cover_state: book['cover_state'])
    new_book.label = relevant_label
    new_book
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
