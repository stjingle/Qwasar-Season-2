require 'sinatra'
require_relative './my_user_model'
require 'json'

set('views', './views')

enable :sessions

set :port, 8080
set :bind, '0.0.0.0'

get '/users' do
    User.all.collect do |row|
        row.to_hash.to_json
    end
    erb :users
end

post '/sign_in' do
    user = User.filter_PassWord(params['email'], params['password'])
    if user
        session[:user_id] = user.id
        session[:password] = user.password
        "Signed in as #{user.firstname}" 
    else
        "Not authorized"
    end
end

post '/users' do
    User.create(params)
    user = User.filter_PassWord(params['email'], params['password'])
    "User #{user.firstname} created"
end

put '/users' do
    if session[:user_id]
        user_Update = User.update(session[:user_id], :password, params['password'])
        "Password updated for #{user_Update[:firstname]}"
    else
        "Not authorized"
    end
end

delete '/sign_out' do
   if session[:user_id]
    user = User.get(session[:user_id])
    session[:user_id] = nil
    "Signed out #{user.firstname}"
   else
    "Not authorized"
   end
end

delete '/users' do
    if session[:user_id]
        user = User.get(session[:user_id])
        if user
            User.destroy(session[:user_id])
            session[:user_id] = nil
            "User #{user.firstname} deleted"
        else
            "User not found"
        end
    else
        "Not authorized"
    end
end

get '/' do
    erb :index
end
