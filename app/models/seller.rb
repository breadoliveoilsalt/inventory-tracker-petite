class Seller < ActiveRecord::Base

  belongs_to :user
  has_many :seller_product_lines
  has_many :product_lines, through: :seller_product_lines
  has_many :product_items

  def readable_start_date
    if !self.start_date
      "N/A"
    else
      "#{self.start_date.month}/#{self.start_date.day}/#{self.start_date.year}"
    end
  end

  def month_to_s
    self.start_date.month.to_s
  end

  def day_to_s
    self.start_date.day.to_s
  end

  def year_to_s
    self.start_date.year.to_s
  end
end
