class Production < ApplicationRecord
  def total_amount
    production_items.reduce(0) do | sum, item |
      sum + (item.id.nil? ? 0 : item.amount)
    end
  end

  def products
    production_items.includes(:product).uniq(&:product).join(', ')
  end

  has_many :production_items, inverse_of: :production
  accepts_nested_attributes_for :production_items, allow_destroy: true
  validates_presence_of :production_items, :date
  validates_associated :production_items

  def self.shown_fields
    %w[ date total_amount products ]
  end

  def self.permitted_params
    super + [{'production_items_attributes': %w[ id _destroy product_id amount ]}]
  end

end
