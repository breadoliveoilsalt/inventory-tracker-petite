class ProductItemsController < ApplicationController

  patch '/product_items/:id' do # patch request to edit a product item
    item = ProductItem.find(params[:id])
    item.update(params[:item])
    item.save
    flash[:message] = "**** Item \# #{item.id} updated ****"
    redirect to "/product_lines/#{item.product_line_id}"
  end

  delete '/product_items/:id/delete' do
    item = ProductItem.find(params[:id])
    item.delete
    flash[:message] = "**** Item \# #{item.id} deleted ****"
    redirect to "/product_lines/#{item.product_line_id}/edit"
  end

end
