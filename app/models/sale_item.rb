class SaleItem < ActiveRecord::Base
  def to_s
    product.to_s
  end
  validates :amount, :price, numericality: { greater_than: 0 }
  belongs_to :product
  belongs_to :sale, inverse_of: :sale_items
end
