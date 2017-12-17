class InventoryItemsController < ApplicationController

  patch '/inventory_items/:id' do # patch request to edit an inventory item
    item = InventoryItem.find(params[:id])
    item.update(params[:inventory_item])
    if item.sold == false
      item.seller = nil
    end
    item.save
    flash[:message] = "**** Item \# #{item.id} updated ****"
    redirect to "/product_lines/#{item.product_line_id}"
  end

  delete '/inventory_items/:id/delete' do # patch request to edit an inventory item
    item = InventoryItem.find(params[:id])
    item.delete
    flash[:message] = "**** Item \# #{item.id} deleted ****"
    redirect to "/product_lines/#{item.product_line_id}/edit"
  end

end
