module Validations
  module Transaction
    module Base
      extend ActiveSupport::Concern

      included do
        validates_presence_of :type_id, :datetime, :amount
        validates :amount, numericality: { greater_than: 0 }

        validates_presence_of :accepted_as_currency, if: :accepted_as_amount?
        validates_presence_of :accepted_as_amount, if: :accepted_as_currency_id?

        validates_presence_of :rate, :asked_currency, if: :to_conversion?
        validates_absence_of  :rate, :asked_currency, unless: :to_conversion?

        validates_presence_of :employee, if: :to_employee?
        validates_absence_of  :employee, unless: :to_employee?

        validate :counter_party_contract, unless: :replace?
      end

      private
      def counter_party_contract
        if from_sale? || to_purchase?
          validates_presence_of :counter_party, :contract
          validate_contract_currency_matches
          self.counter_party = nil
        else
          validates_presence_of :counter_party
          self.contract = nil
        end
      end

      def validate_contract_currency_matches
        if contract&.currency != account&.currency
          invalid_field = counter_party.contracts.one? ? :counter_party : :contract
          errors.add invalid_field, :currencies_does_not_match
        end
      end

    end
  end
end
