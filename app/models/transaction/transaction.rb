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
  validates :amount, numericality: {min: 0.0001}
  validates_presence_of :type_id, :date

  cattr_reader :all_types
  @@all_types = {
            Tushum:  {"Savdodan tushgan": 0, "Boshqa shaxslardan": 1},
            Chiqim: {"Xaridga chiqim": 10,  "Xodimlarga": 11,   "Boshqa shaxslarga": 12},
            Boshqa: {"Pul yechish": 20, "Konversiya": 21}
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  # @@type_values = @@types.values.inject(&:merge)

  enum type_id: @@all_types.values.inject(&:merge)

  # def in_out_type=(value)
  #   self.type_id = @@type_values[value]
  # end

  # def in_out_type
  #   if type_id
  #     @@type_values.key type_id
  #   end
  # end

  # def amount_formatted
  #   amount
  # end

  # belongs_to :reference, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :account
end
