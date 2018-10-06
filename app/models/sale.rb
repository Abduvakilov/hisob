class Sale < ApplicationRecord
  belongs_to :customer, class_name: 'CounterParty'
  belongs_to :user, foreign_key: :created_by_id, optional: true # TODO
  has_many :sales_items, inverse_of: :sale
  accepts_nested_attributes_for :sales_items, allow_destroy: true
  validates_associated :sales_items

  def self.shown_fields
    %w[ date customer discount ]
  end

  def self.permitted_params
    super + [{'sales_items_attributes': %w[ id _destroy product_id price amount ]}]
  end
end
