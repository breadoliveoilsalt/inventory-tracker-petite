class UsersController < ApplicationController

  get '/users/signup' do
    if logged_in?
      redirect to "/users/home"
    else
      erb :'users/create_user'
    end
  end

  post '/users/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to "/"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      erb :'users/home' # Not sure if this is right from a RESTful perspective but running with it for now
    end
  end

  get '/users/login' do
    if logged_in?
      redirect to "/users/home"
    else
      erb :'users/login'
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'/users/home'
    else
      redirect to "/"
    end
  end

  get '/users/home' do
    if logged_in?
      @user = current_user
      erb :"users/home"
    else
      redirect to "/users/login"
    end
  end

  get '/users/logout' do
    if logged_in?
      session.clear
      redirect to "/users/login"
    else
      redirect to '/'
    end
  end

end
