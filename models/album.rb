require('pg')
require_relative('../db/sql_runner')

class Album
  attr_reader( :id, :name, :artist_id, :img )

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @artist_id = options['artist_id']
    @img = options['img']
  end

  def save()
    sql = "INSERT INTO albums (name, artist_id, img) VALUES ('#{@name}', '#{ @artist_id }', '#{@img}') RETURNING *"
    album_data = run_sql(sql)
    @id = album_data.first['id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{ @artist_id }"
    artist_data = run_sql( sql )
    artist = Artist.new(artist_data.first)
    return artist
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums_data = run_sql( sql )
    albums = albums_data.map {|album_data| Album.new(album_data)}
    return albums
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = #{id}"
       album = run_sql(sql)
       result = Album.new(album.first)
       return result
  end

  def self.destroy(id)
    sql= "DELETE FROM albums WHERE id = #{id}"
    run_sql(sql)
  end

  def self.update(options)
    sql = "UPDATE albums SET
           name= '#{options['name']}',
           img = '#{options['img']}',
           artist_id= '#{options['artist_id']}'
           WHERE id = '#{options['id']}'"
       
    run_sql(sql)
  end

end
