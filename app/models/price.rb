class Price < ApplicationRecord

  def products
    product || product_type
  end

  def for_unit
    for_base_unit ? price * product.unit.ratio_to_base_unit : price
  end

  def unit
    for_base_unit ? product.base_unit : product.unit if for_base_unit?
  end

  def self.shown_fields
    %w[date products price unit price_type notes]
  end

  validates_presence_of :date, :price
  validates_presence_of :product,      unless: :product_type_id?
  validates_presence_of :product_type, unless: :product_id?

  belongs_to :product, optional: true
  belongs_to :product_type, class_name: 'Category', optional: true
  belongs_to :price_type,   class_name: 'Category'
  belongs_to :currency

end
