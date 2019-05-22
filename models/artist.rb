require('pg')
require_relative('../db/sql_runner.rb')
require_relative('album.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'] if options['id']
  end

  def save()
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id;'
    values = [@name]
    results = SqlRunner.run(sql, values)
    id_string = results[0]['id']
    @id = id_string.to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    album_objects = album_hashes.map{|album| Album.new(album)}
    return album_objects
  end

  def update_artist()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist_hashes = SqlRunner.run(sql, values)
    artist_objects = artist_hashes.map{|artist| Artist.new(artist)}
    return artist_objects
  end

  def self.delete_all()
    sql = 'DELETE FROM artists;'
    SqlRunner.run(sql)
  end

  def self.list()
    sql = 'SELECT * FROM artists;'
    artist_hashes = SqlRunner.run(sql)
    artist_objects = artist_hashes.map{|artist| Artist.new(artist)}
    return artist_objects
  end

end
