class Transaction < ApplicationRecord
  validates :amount, numericality: {min: 0.0001}
  validates_presence_of :type_id

  cattr_reader :types, :type_values
  @@types = {
            Kirim:  [:income, :receivableback, :payable],
            Chiqim: [:expense,  :receivable,   :payableback],
            Boshqa: [:withdrawal, :conversion]
            # Togirlash: [:kopaytirish, :kamaytirish]
            }

  @@type_values = @@types.values.flatten

  def type=(value)
    self.type_id = @@type_values.find_index(value) 
  end

  def type
    if type_id
      @@type_values[type_id]
    else
      nil
    end
  end


  # belongs_to :reference, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :account
end
