require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, archived, publisher, cover_state)
    super(publish_date, archived)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_s
    # TODO: Add title and author
    "Publisher: #{@publisher}, Publish date: #{@publish_date}, Cover state: #{@cover_state}, Archived: #{@archived}"
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
