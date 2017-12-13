class SellerProductLine < ActiveRecord::Base

  belongs_to :seller
  belongs_to :product_line

end
