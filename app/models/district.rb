class District < ApplicationRecord
  belongs_to :parent_district,  class_name: :District, foreign_key: :district_id, optional: true
  has_many   :child_categories, class_name: :District
end
