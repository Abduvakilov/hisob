# == Schema Information
#
# Table name: districts
#
#  id          :integer          not null, primary key
#  is_active   :boolean
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :integer
#
# Indexes
#
#  index_districts_on_district_id  (district_id)
#

class District < ApplicationRecord
  belongs_to :parent_district,  class_name: :District, foreign_key: :district_id, optional: true
  has_many   :child_categories, class_name: :District
end
