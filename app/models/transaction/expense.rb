#  amount           :float
#  coefficient      :float            default(100.0)
#  datetime         :datetime
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
    if amount - amount_was.to_f > account.balance
      errors.add :amount, :is_more_than_account_balance
    end
  end

end
