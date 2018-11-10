class District < ApplicationRecord

	def to_s
		@name || ''
	end

	validates_presence_of :name

  belongs_to :parent_district, class_name: 'District', foreign_key: :parent_district_id, optional: true
  has_many   :child_districts, -> { kept }, class_name: 'District'
end
