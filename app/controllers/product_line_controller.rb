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
      flash[:message] = "**** Error: Please make sure name is entered or inventory is a valid number ****"
      redirect to '/product_lines/new'
    elsif inventory_error?
      flash[:message] = "**** Error: Please enter a valid number for the inventory ****"
      redirect to '/product_lines/new'
    else
      product_line = ProductLine.create(params[:product_line])
      product_line.user = current_user
      if params[:inventory] != ""
        ProductItem.create_inventory(product_line, params[:inventory])
      end
      product_line.save
    end
    redirect to "/product_lines/#{product_line.id}"
  end

  get '/product_lines/:id' do # get request to show a product line
    if logged_in?
      @product_line = ProductLine.find(params[:id])
      erb :'product_lines/show_product_line'
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end

  get '/product_lines/:id/edit' do # get request to edit a product line
    @product_line = ProductLine.find(params[:id])
    if logged_in?
      if @product_line.user != current_user # This prevents users from editing/deleting what they did not create
        flash[:message] = "**** You do not have permission to edit this Product Line ****"
        redirect to "/product_lines/#{@product_line.id}"
      else
        erb :'product_lines/edit_product_line'
      end
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end

  patch '/product_lines/:id' do # patch request to edit a product line
    product_line = ProductLine.find(params[:id])
    if name_blank?
      flash[:message] = "**** Error: Please enter at least a name **** "
      redirect to "product_lines/#{product_line.id}/edit"
    elsif inventory_error?
      flash[:message] = "**** Error: Please enter a valid number for the inventory ****"
      redirect to "product_lines/#{product_line.id}/edit"
    else
      product_line.update(params[:product_line])
      if params[:inventory] != ""
        ProductItem.create_inventory(product_line, params[:inventory])
      end
      product_line.save
      flash[:message] = "**** Product Line updated ****"
      redirect to "/product_lines/#{product_line.id}"
    end
  end

  delete '/product_lines/:id/delete' do # delete request to delete product line
    product_line = ProductLine.find(params[:id])
    product_line.product_items.each do |item|
      item.delete
    end
    product_line.delete
    flash[:message] = "**** Product Line #{product_line.product_name} deleted ****"
    redirect to '/users/home'
  end

  helpers do

    def name_blank?
      params[:product_line][:product_name] == ""
    end

    def inventory_error?
      params[:inventory] != "" && params[:inventory].to_i == 0
    end

  end # end of helpers

end
