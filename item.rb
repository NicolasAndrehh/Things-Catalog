require 'date'

class Item
  attr_reader :genre, :author, :label
  attr_accessor :publish_date, :archived, :title

  def initialize(publish_date, archived, title)
    @id = rand(1000)
    @publish_date = publish_date
    @archived = archived
    @title = title
  end

  def genre=(genre)
    @genre&.items&.delete(self)
    @genre = genre
    genre.items << self
  end

  def author=(author)
    @author.items.delete(self)
    @author = author
    @author.items << self
  end

  def label=(label)
    @label.items.delete(self)
    @label = label
    @label.items << self
  end

  def move_to_archive
    @archived = true if can_be_archived?
    self
  end

  private

  def can_be_archived?
    Date.today.year - @publish_date.year > 10
  end
end
