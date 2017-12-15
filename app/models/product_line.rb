class ProductLine < ActiveRecord::Base

  belongs_to :user
  has_many :seller_product_lines
  has_many :sellers, through: :seller_product_lines
  has_many :product_items


  def inventory_available
    amount_available = 0
    self.product_items.each do |item|
      if item.sold == false
        amount_available += 1
      end
    end
    amount_available
  end


end
