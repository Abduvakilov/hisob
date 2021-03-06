class Sale < ApplicationRecord

  def currency
    contract&.currency
  end

  def total_amount
    sale_items.where.not(id: nil).reduce(0) do | sum, item |
      sum + item.amount
    end
  end

  def total
    sale_items.where.not(id: nil).reduce(0) do | sum, item |
      sum + item.price * item.amount
    end
  end

  def to_be_paid
    total - discount.to_f
  end

  def products
    sale_items.includes(:product).uniq(&:product).join(', ')
  end

  belongs_to :contract
  # belongs_to :user, foreign_key: :created_by_id, optional: true # TODO
  has_many :sale_items, inverse_of: :sale
  accepts_nested_attributes_for :sale_items, allow_destroy: true
  validates_presence_of :sale_items, :datetime
  validates_associated :sale_items

  validate :contract_in_date

  def contract_in_date
    unless contract.in_date?
      errors.add :contract, :out_of_date
    end
  end

  def self.shown_fields
    %w[ datetime contract_counter_party total_amount to_be_paid products ]
  end

  def self.permitted_params
    super + [{'sale_items_attributes': %w[ id _destroy product_id price amount ]}]
  end

end
