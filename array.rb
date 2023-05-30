class Array
  def to_numbered_s
    map.with_index { |elem, i| "#{i + 1}. #{elem}" }
  end
end
