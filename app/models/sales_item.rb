class SalesItem < ApplicationRecord
  validates :amount, :price, numericality: { greater_than: 0 }
  validates_presence_of :product_id
  belongs_to :product
  belongs_to :sale, inverse_of: :sales_items
end
