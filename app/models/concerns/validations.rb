module Validations
  module Transaction
    module Base
      extend ActiveSupport::Concern

      included do
        validates_presence_of :type_id, :datetime
        validates :amount, numericality: { greater_than: 0 }

        validates_presence_of :accepted_as_currency, if: :accepted_as_amount?
        validates_presence_of :accepted_as_amount, if: :accepted_as_currency_id?

        validates_presence_of :rate, :asked_currency, if: :to_conversion?
        validates_absence_of  :rate, :asked_currency, unless: :to_conversion?

        validates_presence_of :counter_account, if: :replace?
        validates_absence_of  :counter_account, unless: :replace?

        validate :counter?, unless: :replace?
      end

      private
      def counter?
        if to_employee?
          validates_presence_of :employee
          self.counter_party = nil
          self.contract = nil
        elsif from_sale?
          validates_presence_of :counter_party, :contract
          validate_contract_currency_matches
          self.counter_party = nil
          self.employee = nil
        elsif !to_purchase? || !to_other?
          validates_presence_of :counter_party
          self.contract = nil
          self.employee = nil
        end
      end

      def validate_contract_currency_matches
        if contract && contract.currency != account.currency
          invalid_field = counter_party.contracts.one? ? :counter_party : :contract
          errors.add invalid_field, :currencies_does_not_match
        end
      end

    end
  end
end
