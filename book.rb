require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(id: rand(1000), publish_date: nil, archived: nil, publisher: nil, cover_state: nil)
    super(id: id, publish_date: publish_date, archived: archived)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_s
    # TODO: Add title and author
    "#{@id}. Publisher: #{@publisher}, Publish date: #{@publish_date}, Cover state: #{@cover_state}, " \
      "Archived: #{@archived}"
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
