require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative('../models/artist')
require_relative('../models/album')

get '/artists' do
  @artists = Artist.all()
  erb(:'artists/index')
end

get '/artists/search' do
  @artist = Artist.search(params[:search])
  erb(:'/artists/show')
end

get '/artists/new' do
  @albums = Album.all
  erb(:'artists/new')
end

post '/artists' do
  @artist = Artist.new(params)
  @artist.save()
  erb(:'artists/create')
end

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  erb(:'artists/show')
end



post '/artists/:id/delete' do
  Artist.destroy(params[:id])
  redirect to("/artists")
end

get '/artists/:id/edit' do
  @artist = Artist.find(params[:id])
  erb(:'artists/edit')
end

post '/artists/:id' do
  @artist = Artist.update(params)
  erb("/artists/#{params[:id]}")
end






