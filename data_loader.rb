class DataLoader
  def initialize(app)
    @app = app
  end

  def load_file(file_name)
    file_path = File.join('data', file_name)
    return [] unless File.exist?(file_path) && File.size(file_path).positive?

    data = JSON.load_file(file_path)
    helper_data = { labels: @app.labels, genres: @app.genres }
    data.map { |elem| Object.const_get(elem['type']).from_parsed_json(elem, helper_data) }
  end

  def load_games_data
    games_data = load_file('./data/games.json')

    games_data.each do |game_data|
      new_game = Game.new(game_data['multiplayer'], game_data['last_played_at'], game_data['publish_date'],
                          game_data['archived'], game_data['title'])

      new_game.author = @app.authors.find do |author|
        author_first_name, author_last_name = game_data['author'].split
        author.first_name == author_first_name && author.last_name == author_last_name
      end
      @app.games << new_game
    end
  end

  def load_authors_data
    authors_data = load_file('./data/authors.json')
    authors_data.each do |author_data|
      new_author = Author.new(author_data['first_name'], author_data['last_name'])
      @app.authors << new_author
    end
  end
end
