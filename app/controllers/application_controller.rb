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
    # if logged_in?
    #   user = User.find(current_user.id)
    #   redirect to "/users/#{user.slug}"
    # else
      erb :welcome
    # end
  end


  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
