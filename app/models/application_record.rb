class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  extend Table::Fields
  extend Table::Search
  extend Table::Sort

  def to_str
    to_s
  end


end
