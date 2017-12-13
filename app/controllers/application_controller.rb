require './config/environment'
# Problaby don't need the line above, no?

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "lubbalubba"
  end

  get "/" do
    erb :welcome
  end

end
