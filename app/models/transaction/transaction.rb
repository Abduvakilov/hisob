# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  amount           :float
#  coefficient      :float            default(100.0)
#  date             :date
#  notes            :text
#  reference_type   :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :integer
#  counter_party_id :integer
#  reference_id     :integer
#  type_id          :integer
#
# Indexes
#
#  index_transactions_on_account_id        (account_id)
#  index_transactions_on_counter_party_id  (counter_party_id)
#

class Transaction < ApplicationRecord
  default_scope { order('date desc, created_at desc') }
  validates :amount, numericality: {greater_than: 0}
  validates_presence_of :type_id, :date

  cattr_reader :all_types
  @@all_types = {
            Kirim:  {"Savdodan": 0, "Konversiyadan": 1, "Boshqalardan": 2},
            Chiqim: {"Xaridga": 10, "Konversiyaga": 11,  "Xodimlarga": 12, "Boshqalarga": 13},
            Ko‘chirish: {"Ko‘chirish": 20}
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  enum type_id: @@all_types.values.inject(&:merge)

  def type
    @@all_types.keys[type_id_before_type_cast / 10]
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
