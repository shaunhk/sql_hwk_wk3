require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :name
  attr_accessor :id

  def initialize(options)
    @name = options['name']
    @id = options['id'] if options['id']
  end

  def self.delete_all()
    sql = 'DELETE FROM artists;'
    SqlRunner.run(sql)
  end

  def save()
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id;'
    values = [@name]
    results = SqlRunner.run(sql, values)
    id_string = results[0]['id']
    @id = id_string.to_i
  end

  def self.list()
    sql = 'SELECT * FROM artists;'
    artist_hashes = SqlRunner.run(sql)
    artist_objects = artist_hashes.map{|artist| Artist.new(artist)}
    return artist_objects
  end

end
