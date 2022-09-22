album_infos = 100.times.flat_map do |i|
  10.times.map do |j|
    ["Album #{i}", j, "Artist #{j}"]
  end
end

#
# Lighter on memory, Better lookup performance for alumbs with tracks
# But worst performance albums lookup
#
albums = {}
album_infos.each do |album, track, artist|
  ((albums[album] ||= {})[track] ||= []) << artist
end

lookup = ->(album, track=nil) do
  if track
    # dig is similar to lodash _.get, basically nil safe lookup
    albums.dig(album, track)
  else
    a = albums[album].each_value.to_a
    a.flatten!
    a.uniq!
    a
  end
end
