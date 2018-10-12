#  amount           :float
#  coefficient      :float            default(100.0)
#  date             :date
#  notes            :text
#  reference_type   :string
#  account_id       :integer
#  counter_party_id :integer
#  reference_id     :integer
#  type_id          :integer
#  counter_account_id :integer
#  rate             :float
class Income < Transaction

	validates_presence_of :counter_party

	enum type_id: all_types[:income]

end
