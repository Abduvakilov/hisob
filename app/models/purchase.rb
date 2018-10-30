class Purchase < ApplicationRecord

  def currency
    contract&.currency
  end

  def total_amount
    purchase_items.where.not(id: nil).reduce(0) do | sum, item |
      sum + item.amount
    end
  end

  def total
    purchase_items.where.not(id: nil).reduce(0) do | sum, item |
      sum + item.price * item.amount
    end
  end

  def to_be_paid
    total - discount.to_f
  end

  def products
    purchase_items.includes(:product).uniq(&:product).join(', ')
  end

  belongs_to :contract
  # belongs_to :user, foreign_key: :created_by_id, optional: true # TODO
  has_many :purchase_items, inverse_of: :purchase
  accepts_nested_attributes_for :purchase_items, allow_destroy: true
  validates_presence_of :purchase_items, :datetime
  validates_associated :purchase_items


  def self.shown_fields
    %w[ datetime counter_party total_amount to_be_paid products ]
  end

  def self.permitted_params
    super + [{'purchase_items_attributes': %w[ id _destroy product_id price amount ]}]
  end

end
