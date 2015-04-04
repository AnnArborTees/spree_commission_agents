module Spree
  module Admin
    class CommissionPaymentsController < ResourceController
      belongs_to 'spree/user'
      before_filter :find_user
      before_filter :initialize_payment, only: [:new, :index]

      def commission_balance
      end

      private

      def find_user
        @user = Spree::User.find(params[:user_id])
      end

      def initialize_payment
        @commission_payment = Spree::CommissionPayment.new
      end


    end
  end
end
