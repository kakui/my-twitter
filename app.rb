require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite:///microblog.sqlite3"
set :sessions => true

require './models'

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true

def current_user
	#if user signed in
	if session[:user_id]
	#return user object
		User.find(session[:user_id])
	else
	#otherwise return nil
		nil
	end
end

get '/' do
	@user = current_user
	erb :signin
	# @user  User.find(session[:user_id]) if session[:user_id]
	## This was made simpler with the function current_user
	# puts "USER ID is" + session[:user_id].to_s if session[:user_id]
	## This just shows User ID on terminal
end

post '/sessions/new' do
	#.first at the end turns array into object and the first row that matches "email"
	@user = User.where(email: params[:email]).first 
	#if exist, check pw
	if @user && @user.password == params[:password]
		flash[:notice] = "You've been successfully logged in."
		#have app remember that they're logged in
		#this is not working
		session[:user_id] = @user.id
		redirect '/personal'
	else
		flash[:alert] = "There was a problem signing you in. Please try again"
		redirect '/'
	end
	# puts "PARAMS ARE" + params.inspect
	## This just shows email and pw on terminal. Checks if input is working.
end

get '/users/new' do
	erb :signup
end

post '/users/new' do
	User.create(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password])
	# puts "PARAMS ARE" + params.inspect
	# puts params[:last_name]
	## This just shows last name on terminal.
	redirect '/'
end

get '/personal' do
	erb :personal
end

post '/personal' do
	Post.create(entry: params[:entry], user_id: current_user.id)
	redirect '/personal'
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end

=begin

1.Need to associate post to user
	Is Post a join table?
	What does params do again?
2. display post on personal.erb by using something similar to <%=@user.fname if@user%>


Post.create(entry: params[:entry], user_id: current_user.id)

=end