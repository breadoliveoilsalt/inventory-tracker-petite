class ProductLinesController < ApplicationController

  get '/product_lines/new' do # request for form to create new product line

    if logged_in?
      erb :"/product_lines/create_product_line"
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end

  end

  post '/product_lines' do # post request to add a new product line

    if name_blank?
      flash[:message] = "**** Error: Please enter at least a name ****"
      redirect to '/product_lines/new'
    else
      product_line = ProductLine.create(params[:product_line])
      product_line.user = current_user
      # if params[:inventory]
      #   product_line.create_inventory
      # end

      product_line.save

    end
    redirect to "users/home" #"/sellers/#{seller.id}"

  end

  get '/product_lines/:id' do
    if logged_in?
      @product_line = ProductLine.find(params[:id])
      erb :'product_lines/show_product_line'
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end



  get '/product_lines/:id/edit' do #### FIX!!
    @product_line = ProductLine.find(params[:id])
    if logged_in?
      # Immediately below is the gatekeeper preventing users from editing or deleting what
      # they did not create
      if @product_line.user != current_user
        flash[:message] = "**** You do not have permission to edit this seller ****"
        redirect to "/sellers/#{@seller.id}"
      else
        erb :'product_lines/edit_product_line'
      end
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end


  helpers do

    # def valid_date?(date_data)
    #   date_data[:year].to_i.between?(1979, 2100) && create_date_object(date_data)
    # end
    #
    # def create_date_object(date_data)
    #   year = date_data[:year].to_i
    #   month = date_data[:month].to_i
    #   day = date_data[:day].to_i
    #   Date.new(year, month, day)
    # end

    def name_blank?
      params[:product_line][:product_name] == ""
    end

  end # end of helpers

end
