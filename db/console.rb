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
album1.save()


binding.pry
nil
