class ProductionItem < ActiveRecord::Base
  validates :amount, presence: true, numericality: { greater_than: 0 }
  belongs_to :product
  belongs_to :production, inverse_of: :production_items
end
