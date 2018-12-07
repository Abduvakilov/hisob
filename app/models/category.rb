class Category < ApplicationRecord

  def self.main_price_type
    Category.kept.where(for: Price.name)
  end

  validates_presence_of :name
  # enum type_id: [:product, :product_price_history, :counter_party, :company]

  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many   :child_categories, -> {kept}, class_name: 'Category'

  def to_s
    name
  end

  def self.shown_fields
    %w[ name parent_category notes ]
  end

  def self.form_fields
    %w[ name parent_category notes ]
  end

end
