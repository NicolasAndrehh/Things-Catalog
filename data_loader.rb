class DataLoader 

    def initialize(app)
        @app = app
    end

    def load_file(file_path)
        return [] unless File.exist?(file_path) && File.size(file_path).positive?
    
        JSON.load_file(file_path)
      end
    
      def load_data(file_name)
        file_path = File.join('data', file_name)
        data = load_file(file_path)
        helper_data = { labels: @app.labels }
        data.map { |elem| Object.const_get(elem['type']).from_parsed_json(elem, helper_data) }
      end
    
      def load_music_albums_data
        music_albums_data = load_file('./data/music_albums.json')
    
        music_albums_data.each do |music_album_data|
          new_music_album = MusicAlbum.new(music_album_data['on_spotify'], music_album_data['publish_date'],
                                           music_album_data['archived'], music_album_data['title'])
    
          new_music_album.genre = @app.genres.find { |genre| genre.name == music_album_data['genre'] }
          @app.music_albums << new_music_album
        end
      end
    
      def load_genres_data
        genres_data = load_file('./data/genres.json')
    
        genres_data.each do |genre_data|
          new_genre = Genre.new(genre_data['name']) unless @app.genres.include?(genre_data['name'])
          @app.genres << new_genre
        end
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
