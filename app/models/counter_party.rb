class CounterParty < ApplicationRecord
  belongs_to :district, optional: true
  belongs_to :category, optional: true
end
