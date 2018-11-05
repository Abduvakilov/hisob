class Price < ApplicationRecord
  validates_presence_of :price
  validates_presence_of :product, unless: :category_id?
  validates_presence_of :category, unless: :product_id?

  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :price_category, class_name: 'Category'
  belongs_to :currency
end