require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at, publish_date, archived, title)
    super(publish_date: publish_date, archived: archived, title: title)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && (Date.today.year - @last_played_at.year > 2)
  end

  def self.from_parsed_json(game, helper_data)
    new_game = new(game['multiplayer'], game['last_played_at'], game['publish_date'], game['archived'], game['title'])
    new_game.author = helper_data[:authors].find do |author|
      author_first_name, author_last_name = game['author'].split
      author.first_name == author_first_name && author.last_name == author_last_name
    end
    new_game
  end
end
