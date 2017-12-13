class SellersController < ApplicationController


  get '/sellers/new' do # request for form to create new seller
    if logged_in?
      erb :"/sellers/create_seller"
    else
      redirect to '/users/login'
    end
  end


  post '/sellers' do # post request to add a new seller
    if params[:seller_name] == ""
      "Please enter at least a name."
    else
      seller = Seller.create(seller_name: params[:seller_name], user_id: current_user.id)
      if valid_date?(params[:start_date])
        seller.start_date = create_date_object(params[:start_date])
        seller.save
      else
        # Need Flash -- Start Date not entered or invalid.  Click "edit" below to add start Date
      end

    end
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

  end # end of helpers

end
