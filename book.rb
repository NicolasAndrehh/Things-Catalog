require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(args)
    super(id: args[:id], publish_date: args[:publish_date], archived: args[:archived], title: args[:title])
    @publisher = args[:publisher]
    @cover_state = args[:cover_state]
  end

  def to_s
    # TODO: Add author
    "#{@id}. Title: #{@title}, Publisher: #{@publisher}, Publish date: #{@publish_date}, " \
      "Cover state: #{@cover_state}, Archived: #{@archived}"
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
