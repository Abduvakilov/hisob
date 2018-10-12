class Purchase < ApplicationRecord

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

  belongs_to :currency
  belongs_to :supplier, class_name: 'CounterParty'
  belongs_to :user, foreign_key: :created_by_id, optional: true # TODO
  has_many :purchase_items, inverse_of: :purchase
  accepts_nested_attributes_for :purchase_items, allow_destroy: true
  validates_presence_of :purchase_items, :date
  validates_associated :purchase_items


  def self.shown_fields
    %w[ date supplier total_amount to_be_paid products ]
  end

  def self.permitted_params
    super + [{'purchase_items_attributes': %w[ id _destroy product_id price amount ]}]
  end

end
