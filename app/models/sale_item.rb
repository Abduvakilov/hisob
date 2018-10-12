class SaleItem < ActiveRecord::Base
  validates :amount, :price, numericality: { greater_than: 0 }
  belongs_to :product
  belongs_to :sale, inverse_of: :sale_items
end
