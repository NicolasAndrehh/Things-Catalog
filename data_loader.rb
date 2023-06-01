class DataLoader
  def initialize(app)
    @app = app
  end

  def load_file(file_name)
    file_path = File.join('data', file_name)
    return [] unless File.exist?(file_path) && File.size(file_path).positive?

    data = JSON.load_file(file_path)
    helper_data = { labels: @app.labels, genres: @app.genres, authors: @app.authors }
    data.map { |elem| Object.const_get(elem['type']).from_parsed_json(elem, helper_data) }
  end
end
