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
class Expense < Transaction

	validates_presence_of :counter_party
  validate :sufficient_balance, if: -> { [amount, account].all? &:present? }

	enum type_id: @@all_types[:expense]

  private

  def sufficient_balance
    if self.amount > self.account.leftover
      errors.add :amount, :is_more_than_account_leftover
    end
  end

end
