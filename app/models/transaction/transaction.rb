class Transaction < ApplicationRecord
  extend Filter
  include Validations::Transaction::Base

  ALL_TYPES = {
    income:  {from_sale: 0, from_conversion: 1, from_others: 2},
    expense: {to_purchase: 10, to_conversion: 11,  to_employee: 12, to_other: 13},
    replace: {replace: 20}
    # Togirlash: [:kopaytirish, :kamaytirish]
  }

  enum type_id: ALL_TYPES.values.inject(&:merge)

  def counter
    counter_party || contract&.counter_party || counter_account
  end

  def self.all_i
    where(type_id: type_ids.values)
  end

  def self.kept_i
    kept.all_i
  end

  def self.human_type_names
    @@human_type_names ||= ALL_TYPES.map{ |k,v| [I18n.t("activerecord.models.#{k}.one"), v.map{|a,b|[human_attribute_name(a), b]}] }
  end

  def self.models
    @@models ||= ALL_TYPES.keys.map { |key| key.to_s.classify.constantize }
  end

  def self.modeled_find(_pk)
    transaction = find(_pk)
    transaction.becomes self.models[transaction.type_id_before_type_cast/10]
  end

  def type
    ALL_TYPES.keys[ type_id_before_type_cast / 10 ]
  end

  ALL_TYPES.keys.each do |_type|
    define_method("#{_type}?") {
      type == _type
    }
  end

  def self.shown_fields
    %w[datetime type_id amount account counter notes accepted_as_amount accepted_as_currency]
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
