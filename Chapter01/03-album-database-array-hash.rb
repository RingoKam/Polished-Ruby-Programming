album_infos = 100.times.flat_map do |i|
  10.times.map do |j|
    ["Album #{i}", j, "Artist #{j}"]
  end
end

# More memory efficient than last 2 approach, don't have to create hash
# faster lookup performance when loojup by albums with tracks
albums = {}
album_infos.each do |album, track, artist|
  album_array = albums[album] ||= [[]]
  # index 0 of the album array contain all artist for the album
  album_array[0] << artist
  # since we know track is an int, 
  # we can treat it as index and save associate artist to it 
  (album_array[track] ||= []) << artist
end
albums.each_value do |array|
  array[0].uniq!
end

lookup = ->(album, track=0) do
  albums.dig(album, track)
end
