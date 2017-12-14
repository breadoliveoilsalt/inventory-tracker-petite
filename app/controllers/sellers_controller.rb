class SellersController < ApplicationController


  get '/sellers/new' do # request for form to create new seller
    if logged_in?
      erb :"/sellers/create_seller"
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end

  end

  post '/sellers' do # post request to add a new seller
    if name_blank?
      flash[:message] = "**** Error: Please enter at least a name ****"
      redirect to '/sellers/new'
    else
      seller = Seller.create(seller_name: params[:seller][:seller_name], user_id: current_user.id)
      if valid_date?(params[:start_date])
        seller.start_date = create_date_object(params[:start_date])
        seller.save
      else
        flash[:message] = "**** Note: Start date was not entered or was invalid. Click edit to add a start date ****"
      end
      redirect to "/sellers/#{seller.id}"
    end
  end

  get '/sellers/:id' do
    if logged_in?
      @seller = Seller.find(params[:id])
      erb :'sellers/show_seller'
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end

  get '/sellers/:id/edit' do
    @seller = Seller.find(params[:id])
    if logged_in?
      # Immediately below is the gatekeeper preventing users from editing or deleting sellers 
      # that they did not create
      if @seller.user != current_user
        flash[:message] = "**** You do not have permission to edit this seller ****"
        redirect to "/sellers/#{@seller.id}"
      else
        erb :'sellers/edit_seller'
      end
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end

  patch '/sellers/:id' do # patch request to edit seller
    seller = Seller.find(params[:id])
    if name_blank?
      flash[:message] = "**** Error: Please enter at least a name **** "
      redirect to "sellers/#{seller.id}/edit"
    else
      seller.update(params[:seller])
      if valid_date?(params[:start_date])
        seller.start_date = create_date_object(params[:start_date])
      else
        seller.start_date = nil
        flash[:message] = " **** Note: Start date was not entered or was invalid. Click edit to add a start date ****"
      end
      seller.save
      redirect to "/sellers/#{seller.id}"
    end
  end

  delete '/sellers/:id/delete' do # delete request to edit seller
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
