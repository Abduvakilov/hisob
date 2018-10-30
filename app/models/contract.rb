class Contract < ActiveRecord::Base

  scope :ordered, -> {}

  include Discard::Model
  extend Table::Fields
  extend Table::Sort

  # def self.permitted_params
  #   super - ['counter_party_id']
  # end

  belongs_to :category, optional: true
  belongs_to :counter_party
  belongs_to :currency
end
