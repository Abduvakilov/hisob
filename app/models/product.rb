#  id          :integer          not null, primary key
#  is_for_sale :boolean          default(FALSE)
#  name        :string
#  category_id :integer
#  company_id  :integer
class Product < ApplicationRecord

  def leftover
    production = Production.joins(:production_items).kept.where(production_items: {product: self}).sum 'production_items.amount'
    purchase = Purchase.joins(:purchase_items).kept.where(purchase_items: {product: self}).sum 'purchase_items.amount'
    sale = Sale.joins(:sale_items).kept.where(sale_items: {product: self}).sum 'sale_items.amount'
    production + purchase - sale
  end

  def to_s
    name
  end

  def price=(value)
    self.product_price_histories.create price: value
  end

  def price
    self.product_price_histories.order('created_at DESC').limit(1).first.price
  end

  def self.shown_fields
    %w[name leftover unit is_for_sale company category include_base_unit]
  end

  has_many :sales_items
  has_many :product_price_histories
  belongs_to :unit, optional: true
  belongs_to :company, optional: true
  belongs_to :category, optional: true


end
