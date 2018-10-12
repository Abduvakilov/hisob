class Production < ApplicationRecord
  def total_amount
    production_items.where.not(id: nil).reduce(0) do | sum, item |
      sum + item.amount
    end
  end

  has_many :production_items, inverse_of: :production
  accepts_nested_attributes_for :production_items, allow_destroy: true
  validates_presence_of :production_items, :date
  validates_associated :production_items

  def self.shown_fields
    %w[ date total_amount ]
  end

  def self.permitted_params
    super + [{'production_items_attributes': %w[ id _destroy product_id amount ]}]
  end

end
