class SellersController < ApplicationController


  get '/sellers/new' do # request for form to create new seller
    #flash in scope here?
    if logged_in?
      erb :"/sellers/create_seller"
    else
      flash[:message] = "Please log in."
      puts "hello"
      puts "#{flash[:message]}"
      redirect to '/users/login'
      # Flash: consider flash error message to please log in
    end

  end


  post '/sellers' do # post request to add a new seller
    if name_blank?
      # Flash: consider flash error message to please at least enter name
      "Please enter at least a name."
    else
      seller = Seller.create(seller_name: params[:seller][:seller_name], user_id: current_user.id)
      if valid_date?(params[:start_date])
        seller.start_date = create_date_object(params[:start_date])
        seller.save
      else
        #Need flash to work:
        "Start Date not entered or invalid. Click edit below to add start Date"
      end
      redirect to "/sellers/#{seller.id}"
    end
  end

  get '/sellers/:id' do
    if logged_in?
      @seller = Seller.find(params[:id])
      erb :'sellers/show_seller'
    else
      redirect to '/'
    end
  end

  get '/sellers/:id/edit' do
    if logged_in?
      @seller = Seller.find(params[:id])
      erb :'sellers/edit_seller'
    else
      redirect to '/'
      # Flash: consider flash error message to please log in
    end
  end

  patch '/sellers/:id' do # patch request to edit seller
    if name_blank?
      # Flash: consider flash error message to please enter at least name
      "Please enter at least a name."
    else
      seller = Seller.find(params[:id])
      seller.update(params[:seller])
      if valid_date?(params[:start_date])
        seller.start_date = create_date_object(params[:start_date])
      else
        # Flash: consider flash error message to please enter valid date or something
        "Start Date not entered or invalid. Click edit below to add start Date"
      end
      seller.save
      redirect to "/sellers/#{seller.id}"
    end
  end

  delete '/sellers/:id/delete' do # delete request to edit seller
    # Here and in patch, build in that you can't do this unless
    # session[:id] == seller.user_id (or seller.user == current_user)
    seller = Seller.find(params[:id])
    seller.delete
    redirect to '/users/home'
  end

  helpers do

    def valid_date?(date_data)
      date_data[:year].to_i.between?(1979, 2100) && create_date_object(date_data)
    end

    def create_date_object(date_data)
      year = date_data[:year].to_i
      month = date_data[:month].to_i
      day = date_data[:day].to_i
      Date.new(year, month, day)
    end

    def name_blank?
      params[:seller][:seller_name] == ""
    end

  end # end of helpers

end
