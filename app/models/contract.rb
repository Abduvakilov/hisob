class Contract < ActiveRecord::Base

  scope :ordered, -> {}

  include Discard::Model
  extend Table::Fields
  extend Table::Sort

  def with_others
    Contract.kept.where(counter_party_id: counter_party_id)
  end

  def single?
    Contract.kept.where(counter_party_id: counter_party_id).count('id') == 1
  end

  belongs_to :category, optional: true
  belongs_to :counter_party
  belongs_to :currency

  def to_s
    name + ', ' + currency
  end
end
