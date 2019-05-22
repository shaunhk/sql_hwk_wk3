require('pry')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'John Martyn'})
artist1.save()
album1 = Album.new(
  {
    'artist_id' => artist1.id,
    'title' => 'Solid Air',
    'genre' => 'Acoustic'
  }
)
album2 = Album.new(
  {
    'artist_id' => artist1.id,
    'title' => 'Bless The Weather',
    'genre' => 'Easy Listening'
  }
)

artist2 = Artist.new(
  {
    'name' => 'Marilyn Manson'
  }
)
artist2.save()
album3 = Album.new(
  {
  'artist_id' => artist2.id,
  'title' => 'Antichrist Superstar',
  'genre' => 'Metal'
  }
)
album3.save()
album2.save()
album1.save()
album2 = Album.new(
  {
  'artist_id' => artist1.id,
  'title' => 'Bless The Weather',
  'genre' => 'Blues'
  }
)

album2.genre = "Blues"
album2.update_album()
artist2.name = "Marilyn Manson and the Spooky Kids"
artist2.update_artist()

# p Artist.list()
# p Album.list()
# p artist1.albums
# p album1.artist
binding.pry
nil
