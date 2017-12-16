class ProductItemsController < ApplicationController

  patch '/product_items/:id' do # patch request to edit an inventory item
    item = ProductItem.find(params[:id])
    item.update(params[:product_item])
    if item.sold == false
      item.seller = nil
    end
    item.save
    flash[:message] = "**** Item \# #{item.id} updated ****"
    redirect to "/product_lines/#{item.product_line_id}"
  end

  delete '/product_items/:id/delete' do # patch request to edit an inventory item
    item = ProductItem.find(params[:id])
    item.delete
    flash[:message] = "**** Item \# #{item.id} deleted ****"
    redirect to "/product_lines/#{item.product_line_id}/edit"
  end

end
