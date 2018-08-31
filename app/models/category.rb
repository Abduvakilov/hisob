# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  description        :text
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  parent_category_id :integer
#  type_id            :integer
#
# Indexes
#
#  index_categories_on_parent_category_id  (parent_category_id)
#

class Category < ApplicationRecord

  validates_presence_of :name
  enum type_id: [:product, :product_price_history, :counter_party, :company]

  belongs_to :parent_category, class_name: :Category, foreign_key: :parent_category_id, optional: true
  has_many   :child_categories, class_name: :Category


end
