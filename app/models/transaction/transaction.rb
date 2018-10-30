#  amount             :float
#  datetime           :date
#  notes              :text
#  reference_type     :string
#  account_id         :integer
#  counter_party_id   :integer
#  reference_id       :integer
#  type_id            :integer
#  counter_account_id :integer
class Transaction < ApplicationRecord
  extend Filter

  validates :amount, numericality: { greater_than: 0 }
  validates_presence_of :type_id, :datetime
  validates_presence_of :accepted_as_currency, if: :accepted_as_amount?
  validates_presence_of :accepted_as_amount, if: :accepted_as_currency_id?

  cattr_reader :all_types
  @@all_types = {
            income:  {"Savdodan": 0, "Konversiyadan": 1, "Boshqalardan": 2},
            expense: {"Xaridga": 10, "Konversiyaga": 11,  "Xodimlarga": 12, "Boshqalarga": 13},
            replace: {"Ko‘chirish": 20}
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  enum type_id: @@all_types.values.inject(&:merge)

  validates_presence_of :rate, :asked_currency, if: :Konversiyaga?
  validates_absence_of :rate, :asked_currency, unless: :Konversiyaga?

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
  belongs_to :accepted_as_currency, class_name: 'Currency', optional: true
  belongs_to :asked_currency, class_name: 'Currency', optional: true
end
