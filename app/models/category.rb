class Category < ApplicationRecord
  cattr_reader :types
  @@types = [:product, :product_price_history, :counter_party]

  validates_presence_of :name
  validates :type_id, numericality: {greater_than_or_equal_to: 0, less_than: @@types.length}

  def type=(value)
    puts @@types
    self.type_id = @@types.find_index(value)
  end

  def type
    @@types[type_id]
  end

  belongs_to :parent_category, class_name: :Category, foreign_key: :parent_category_id, optional: true
  has_many   :child_categories, class_name: :Category


end
