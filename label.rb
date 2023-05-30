class Label
  attr_accessor :title, :color
  attr_reader :items, :id

  def initialize(id: rand(1000), title: nil, color: nil)
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    item.label = self
  end

  def to_s
    "#{@id}. Title: #{@title}, Color: #{@color}"
  end
end
