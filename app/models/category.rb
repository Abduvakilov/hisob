class Category < ApplicationRecord

  validates_presence_of :name
  # enum type_id: [:product, :product_price_history, :counter_party, :company]

  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many   :child_categories, -> {kept}, class_name: 'Category'

  def to_s
    name
  end

end
