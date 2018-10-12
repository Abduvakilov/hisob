#  company_name :string
#  description  :text
#  email        :string
#  is_customer  :boolean
#  is_supplier  :boolean
#  name         :string
#  phone        :string
#  category_id  :integer
#  district_id  :integer
class CounterParty < ApplicationRecord
  belongs_to :district, optional: true
  belongs_to :category, optional: true
  has_many :sales
  has_many :purchases

  def self.searched_by_childs
  	%w[name company_name]
  end

  def to_s
  	self.name || self.company_name
  end
end
