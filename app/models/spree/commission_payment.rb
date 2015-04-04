module Spree
  class CommissionPayment < ActiveRecord::Base
    belongs_to :user
    PAYMENT_METHODS = %w(PayPal ACH)

    validates :amount, :bring_current_at, :user_id, :payment_method, presence: true
    validate :amount_less_than_balance

    private

    def amount_less_than_balance
      if (!amount.blank? && !bring_current_at.blank?) and amount > user.commission_balance_as_of(bring_current_at)
        errors.add(:amount, "must be less than the balance as of the bring current at date (#{bring_current_at})")
      end
    end

  end
end
