#  id                :integer          not null, primary key
#  date              :datetime
#  price             :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  currency_id       :integer
#  price_category_id :integer
#  product_id        :integer

class ProductPriceHistory < ApplicationRecord
  belongs_to :product
  belongs_to :category
end
