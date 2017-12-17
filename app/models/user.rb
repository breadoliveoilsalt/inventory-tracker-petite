class User < ActiveRecord::Base

  has_secure_password

  has_many :sellers
  has_many :product_lines
  has_many :inventory_items


end
