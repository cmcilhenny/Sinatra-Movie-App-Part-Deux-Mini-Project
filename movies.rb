require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

# A setup step to get rspec tests running.
configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root,'views')
end

get '/' do
	erb :index
end

get '/results' do

	if params[:movie] == ""
		redirect '/error'
	end

	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => "#{params[:movie]}"})
	@result = JSON.parse(response.body)

	# str = "<h1>Movie List</h1>"

 #  result["Search"].each do |movie|
 #    str += "<br><a href=/poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
 #  end
 #  str

  erb :search
end

get '/poster/:imdb_id' do

	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => "#{params[:imdb_id]}"})
	@result = JSON.parse(response.body)
  
  # "<h2>Movie Info</h2>
  # 	<ul>
  # 		<li>#{result["Title"]}</li>
  # 		<li>#{result["Plot"]}</li>
  # 		<li>#{result["Year"]}</li>
  # 		<li>#{result["Rated"]}</li>
  # 		<li>#{result["Runtime"]}</li>
  # 		<li>#{result["Genre"]}</li>
  # 		<li>#{result["Director"]}</li>
  # 		<li>#{result["Actors"]}</li>
  # 		<li><a href='http://www.imdb.com/title/#{result["imdbID"]}'>IMDB Info</a></li>
  # 	</ul>
  #	"<img src = #{result['Poster']}></img>"

  erb :show
end



