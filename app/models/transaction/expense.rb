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

class Expense < Transaction

	enum type_id: @@all_types[:Chiqim]

end
