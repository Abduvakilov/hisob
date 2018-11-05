class Department < ApplicationRecord
  def to_s
    name
  end
  belongs_to :company
  has_many :employees, -> { kept }
end
