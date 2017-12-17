class ProductLine < ActiveRecord::Base

  belongs_to :user
  has_many :seller_product_lines
  has_many :sellers, through: :seller_product_lines
  has_many :inventory_items


  def inventory_available
    amount_available = 0
    self.inventory_items.each do |item|
      if item.sold == false
        amount_available += 1
      end
    end
    amount_available
  end


end
