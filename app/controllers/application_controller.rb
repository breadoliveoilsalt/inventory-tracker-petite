
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "lubbalubba"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
     redirect to "/users/home"
    else
      erb :welcome
    end
  end


  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

  private

  def authenticate_user!
    if !logged_in?
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end

end
