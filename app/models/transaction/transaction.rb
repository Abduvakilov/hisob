class Transaction < ApplicationRecord
  extend Filter
  include Validations::Transaction::Base
  # before_validation :puts_hi
  # validates :amount, numericality: { greater_than: 0 }
  # validates_presence_of :type_id, :datetime
  # validates_presence_of :accepted_as_currency, if: :accepted_as_amount?
  # validates_presence_of :accepted_as_amount, if: :accepted_as_currency_id?

  cattr_reader :all_types
  @@all_types = {
            income:  {from_sale: 0, from_conversion: 1, from_others: 2},
            expense: {to_purchase: 10, to_conversion: 11,  to_employee: 12, to_other: 13},
            replace: {replace: 20}
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  enum type_id: @@all_types.values.inject(&:merge)

  # validates_presence_of :rate, :asked_currency, if: :to_conversion?
  # validates_absence_of :rate, :asked_currency, unless: :to_conversion?

  def self.all_i
    where(type_id: type_ids.values)
  end

  def self.kept_i
    kept.where(type_id: type_ids.values)
  end

  def self.models
    @@models ||= all_types.keys.map { |key| key.to_s.classify.constantize }
  end

  def self.modeled_find(_pk)
    transaction = find(_pk)
    transaction.becomes self.models[transaction.type_id_before_type_cast/10]
  end

  def type
    all_types.keys[ type_id_before_type_cast / 10 ]
  end

  all_types.keys.each do |_type|
    define_method("#{_type}?") {
      type == _type
    }
  end

  def self.shown_fields
    %w[datetime type_id amount account counter_party_or_account notes accepted_as_amount accepted_as_currency]
  end

  def self.searched_fields
    ['notes']
  end

  def self.sortable_fields
    super - ['type_id']
  end

  # belongs_to :reference, optional: true # TODO
  belongs_to :contract, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :counter_account, class_name: 'Account', optional: true
  belongs_to :account
  belongs_to :employee, optional: true
  belongs_to :accepted_as_currency, class_name: 'Currency', optional: true
  belongs_to :asked_currency, class_name: 'Currency', optional: true
end
