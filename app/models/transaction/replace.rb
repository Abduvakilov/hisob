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
class Replace < Transaction

	validates_presence_of :counter_account
	# validates_absence_of :counter_party, :coefficient, :rate, :asked_currency

  validate :account_currencies_match
  validate :different_accounts

  enum type_id: @@all_types[:replace]

  private
  def account_currencies_match
    if account.currency != counter_account.currency
      errors.add :counter_account, :currencies_does_not_match
    end
  end

  def different_accounts
    if account == counter_account
      errors.add :counter_account, :is_the_same
    end
  end

end
