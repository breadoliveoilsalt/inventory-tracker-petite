class ProductLinesController < ApplicationController

  get '/product_lines/:id' do
    if logged_in?
      @product_line = ProductLine.find(params[:id])
      erb :'product_lines/show_product_line'
    else
      flash[:message] = "**** Please log in first ****"
      redirect to '/users/login'
    end
  end



end
