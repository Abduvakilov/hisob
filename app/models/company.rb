class Company < ApplicationRecord
  has_many :products, -> { kept }
  has_many :departments, -> { kept }

  def to_s
  	short_name
  end

end
