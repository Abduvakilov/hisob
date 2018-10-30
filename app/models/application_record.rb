class ApplicationRecord < ActiveRecord::Base

  scope :ordered, -> { order('created_at desc') }

  self.abstract_class = true

  extend Table::Fields
  extend Table::Search
  extend Table::Sort

	# extend Filter

  def to_str
    to_s
  end

  include Discard::Model

end
