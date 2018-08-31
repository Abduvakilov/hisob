#  amount             :float
#  coefficient        :float      default(100.0)
#  date               :date
#  notes              :text
#  reference_type     :string
#  account_id         :integer
#  counter_party_id   :integer
#  reference_id       :integer
#  type_id            :integer
#  counter_account_id :integer
class Transaction < ApplicationRecord
  scope :ordered, -> { order('date desc, created_at desc') }

  validates :amount, numericality: { greater_than: 0 }
  validates_presence_of :type_id, :date

  cattr_reader :all_types
  @@all_types = {
            income:  {"Savdodan": 0, "Konversiyadan": 1, "Boshqalardan": 2},
            expense: {"Xaridga": 10, "Konversiyaga": 11,  "Xodimlarga": 12, "Boshqalarga": 13},
            replace: {"Ko‘chirish": 20}
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  enum type_id: @@all_types.values.inject(&:merge)

  def self.all_i
    where(type_id: type_ids.values)
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
    %w[date type_id amount account counter_party notes coefficient]
  end

  def self.searched_fields
    ['notes']
  end

  def self.sortable_fields
    super - ['type_id']
  end


  # belongs_to :reference, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :counter_account, class_name: 'Account', optional: true
  belongs_to :account
end
