# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  is_active   :boolean          default(TRUE)
#  is_for_sale :boolean          default(FALSE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  company_id  :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_company_id   (company_id)
#

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
