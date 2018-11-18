class Expense < Transaction

  validate :sufficient_balance, if: -> { amount? && account_id? }

  validate :expense_corresponds

	enum type_id: ALL_TYPES[:expense]

  private

  def sufficient_balance
    if amount - amount_was.to_f > account.balance
      errors.add :amount, :is_more_than_account_balance
    end
  end

  def expense_corresponds
    return unless to_purchase? || to_other?
    unless counter_party_id? || expense_type_id?
      errors.add :counter_party, :required
      errors.add :expense_type, :required
    end
  end

end
