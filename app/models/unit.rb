class Unit < ApplicationRecord
  belongs_to :base_unit,  class_name: :Unit, optional: true
  def to_s
    short_name
  end
end
