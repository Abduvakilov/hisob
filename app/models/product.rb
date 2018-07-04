class Product < ApplicationRecord
  def price=(value)
    self.product_price_histories.create price: value
  end

  def price
    self.product_price_histories.order('created_at DESC').limit(1).first.price
  end

  has_many :product_price_histories
  belongs_to :company
  belongs_to :category

 
end
