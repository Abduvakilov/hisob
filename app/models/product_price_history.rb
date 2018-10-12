# == Schema Information
#
# Table name: product_price_histories
#
#  id                :integer          not null, primary key
#  date              :datetime
#  price             :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  currency_id       :integer
#  price_category_id :integer
#  product_id        :integer
#
# Indexes
#
#  index_product_price_histories_on_currency_id        (currency_id)
#  index_product_price_histories_on_price_category_id  (price_category_id)
#  index_product_price_histories_on_product_id         (product_id)
#

class ProductPriceHistory < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
end
