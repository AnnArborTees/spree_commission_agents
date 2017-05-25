module Spree
  module Admin
    class CommissionPaymentsController < ResourceController
      belongs_to 'spree/user'
      before_filter :find_user
      before_filter :initialize_payment, only: [:new, :index]

      def commission_balance
      end

      def recalculate
        count = 0
        missing_only = params[:missing_only] == 'true'

        @user.commission_agents.each do |commission_agent|
          next if commission_agent.product_id.nil?

          line_items = Spree::LineItem
            .joins(:product)
            .where(spree_products: { id: commission_agent.product_id })
            .joins(:variant)
            .includes(:commissions)

          if missing_only
            line_items.select! { |li| li.commissions.empty? }
          end

          line_items.each do |line_item|
            commission = Spree::Commission.find_or_initialize_by(
              line_item_id: line_item.id,
              commission_agent_id: commission_agent.id
            )
            commission.amount = commission_agent.effective_rate(line_item.variant, line_item.adjustment_total)
            commission.save
            count += 1
          end
        end

        redirect_to :back, flash: { success: "Successfully recalculated #{missing_only ? 'missing' : 'all'} commission (#{count} line items)" }
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
