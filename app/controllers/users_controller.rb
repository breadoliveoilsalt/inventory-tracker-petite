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
      flash[:message] = "**** Error: Incomplete credentials ****"
      redirect to "/users/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to "/users/home"
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
      flash[:message] = "**** Error: Invalid log in credentials ****"
      redirect to "/users/login"
    end
  end

  get '/users/home' do
    if logged_in?
      erb :"users/home"
    else
      flash[:message] = "**** Please log in first ****"
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
