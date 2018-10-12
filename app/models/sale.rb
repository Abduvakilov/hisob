class Sale < ApplicationRecord

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

  belongs_to :currency
  belongs_to :customer, class_name: 'CounterParty'
  belongs_to :user, foreign_key: :created_by_id, optional: true # TODO
  has_many :sale_items, inverse_of: :sale
  accepts_nested_attributes_for :sale_items, allow_destroy: true
  validates_presence_of :sale_items, :date
  validates_associated :sale_items


  def self.shown_fields
    %w[ date customer total_amount to_be_paid ]
  end

  def self.permitted_params
    super + [{'sale_items_attributes': %w[ id _destroy product_id price amount ]}]
  end

end
