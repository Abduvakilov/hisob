class PurchaseItem < ActiveRecord::Base
  validates :amount, :price, numericality: { greater_than: 0 }
  belongs_to :product
  belongs_to :purchase, inverse_of: :purchase_items
end
