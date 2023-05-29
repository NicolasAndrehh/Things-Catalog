require_relative 'app'

def main
  app = App.new
  menu = { 'Please select an option' => nil, 'List all books' => :list_books,
           'List all music albums' => :list_music_albums, 'List of games' => :list_games,
           'List all genres' => :list_genres, 'List all labels' => :list_labels, 'List all authors' => :list_authors,
           'Add a book' => :create_book, 'Add a music album' => :create_music_album, 'Add a game' => :create_game,
           'Exit' => :exit }

  puts 'Welcome to the catalog of your things!'
  selected_option = 0
  until selected_option == 10
    puts(menu.keys.map.with_index { |option, i| "#{i.zero? ? '' : "#{i}. "}#{option}" })
    selected_option = gets.chomp.to_i
    if menu.values[selected_option]
      app.public_send(menu.values[selected_option])
    else
      puts 'Please select a valid option'
    end
  end
end

main
