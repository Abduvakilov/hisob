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
  validates :amount, numericality: {min: 0.0001}
  validates_presence_of :type_id, :date

  cattr_reader :all_types
  @@all_types = {
            Tushum:  {"Savdodan tushgan": 0, "Boshqa shaxslardan": 1},
            Chiqim: {"Xaridga chiqim": 10,  "Xodimlarga": 11,   "Boshqa shaxslarga": 12},
            Boshqa: {"Pul yechish": 20, "Konversiya": 21}
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

  # belongs_to :reference, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :account
end
