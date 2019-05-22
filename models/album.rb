require('pg')
require_relative('artist.rb')
require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
      (title, genre, artist_id)
      VALUES (
        $1, $2, $3
        )
      RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist.name
  end


  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.list()
    sql = 'SELECT * FROM albums;'
    album_hashes = SqlRunner.run(sql)
    album_objects = album_hashes.map {|album| Album.new(album)}
    return album_objects
  end

end
