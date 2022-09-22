#
# Consume more memory, if there are large number of album
# Better performance for lookup
#
album_infos = 100.times.flat_map do |i|
  10.times.map do |j|
    ["Album #{i}", j, "Artist #{j}"]
  end
end

album_artists = {}
album_track_artists = {}

album_infos.each do |album, track, artist|
  # Key by album name 
  (album_artists[album] ||= []) << artist
  # Key by array of album and track
  (album_track_artists[[album, track]] ||= []) << artist
end
album_artists.each_value(&:uniq!)

lookup = ->(album, track=nil) do
  if track
    album_track_artists[[album, track]]
  else
    album_artists[album]
  end
end
