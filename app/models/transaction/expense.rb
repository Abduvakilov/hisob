class Expense < Transaction

  validate :sufficient_balance, if: -> { [amount, account].all? &:present? }

	enum type_id: ALL_TYPES[:expense]

  private

  def sufficient_balance
    if amount - amount_was.to_f > account.balance
      errors.add :amount, :is_more_than_account_balance
    end
  end

end
