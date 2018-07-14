class Transaction < ApplicationRecord
  validates :amount, numericality: {min: 0.0001}
  validates_presence_of :type_id, :date

  cattr_reader :types, :type_values
  @@types = {
            Tushum:  ["Savdodan tushgan", "Boshqa shaxslardan"],
            Chiqim: ["Xaridga chiqim",  "Xodimlarga",   "Boshqa shaxslarga"],
            Boshqa: ["Pul yechish", "Konversiya"]
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  @@type_values = @@types.values.flatten

  def in_out_type=(value)
    self.type_id = @@type_values.find_index(value) 
  end

  def in_out_type
    if type_id
      @@type_values[type_id]
    else
      nil
    end
  end

  def amount_formatted
    amount
  end

  # belongs_to :reference, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :account
end
