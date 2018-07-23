# == Schema Information
#
# Table name: counter_parties
#
#  id           :integer          not null, primary key
#  company_name :string
#  description  :text
#  email        :string
#  is_active    :boolean
#  is_customer  :boolean
#  is_supplier  :boolean
#  name         :string
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :integer
#  district_id  :integer
#
# Indexes
#
#  index_counter_parties_on_category_id  (category_id)
#  index_counter_parties_on_district_id  (district_id)
#

class CounterParty < ApplicationRecord
  belongs_to :district, optional: true
  belongs_to :category, optional: true
  
  def self.searched_by_childs
  	%w[name company_name]
  end

  def to_s
  	self.name || self.company_name
  end
end
