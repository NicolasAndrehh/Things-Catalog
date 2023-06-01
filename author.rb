class Author
  attr_accessor :first_name, :last_name, :items

  def initialize(first_name, last_name)
    @id = rand(1000)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    item.author = self
  end

  def self.from_parsed_json(book, _helper_data)
    new(book['first_name'], book['last_name'])
  end
end
