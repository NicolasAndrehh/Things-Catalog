class Genre
  attr_accessor :name, :items

  def initialize(name)
    @id = rand(1000)
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
  end

  def self.from_parsed_json(genre, _helper_data)
    new(genre['name'])
  end
end
