module Spree
  module Admin
    ReportsController.class_eval do

      def commission_total
        @agents = Spree::Role.find_by(name: 'commission agent').users
        if params[:completed_at_gt].blank?
          params[:completed_at_gt] = Time.zone.now.beginning_of_month
        else
          params[:completed_at_gt] = Time.zone.parse(params[:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
        end

        if params && !params[:completed_at_lt].blank?
          params[:completed_at_lt] = Time.zone.parse(params[:completed_at_lt]).end_of_day rescue ""
        end

        @totals = {}
        if params[:agent] and Spree::User.exists?(params[:agent])
          @agent = Spree::User.find(params[:agent])
          @agent.commission_agents.each do |ca|
            @totals[ca.product.name] = {}
            @totals[ca.product.name][:sales_total] = ca.sales(params[:completed_at_gt], params[:completed_at_lt])
            @totals[ca.product.name][:adjustment_total] = ca.discounts(params[:completed_at_gt], params[:completed_at_lt])
            @totals[ca.product.name][:commission_total] = ca.commissions_total(params[:completed_at_gt], params[:completed_at_lt])
          end
        else
          @agents.each do |agent|
            @totals[agent] = {
                sales_total: agent.sales_total(params[:completed_at_gt], params[:completed_at_lt]),
                adjustment_total: agent.adjustments_total(params[:completed_at_gt], params[:completed_at_lt]),
                commission_total: agent.commissions_total(params[:completed_at_gt], params[:completed_at_lt])
            }
          end
        end

      end


      def commission_payment_total
        @agents = Spree::Role.find_by(name: 'commission agent').users
        if params[:created_at_gt].blank?
          params[:created_at_gt] = Time.zone.now.beginning_of_month
        else
          params[:created_at_gt] = Time.zone.parse(params[:created_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
        end

        if params && !params[:created_at_lt].blank?
          params[:created_at_lt] = Time.zone.parse(params[:created_at_lt]).end_of_day rescue ""
        end

        @totals = {}
        if params[:agent] and Spree::User.exists?(params[:agent])
          @agent = Spree::User.find(params[:agent])
          @agent.commission_payments.each do |p|
            @totals[p.created_at.strftime('%F')] = p
          end
        else
          @agents.each do |agent|
            @totals[agent] = {
                payment_total: agent.commission_payments_total(params[:created_at_gt], params[:created_at_lt])
            }
          end
        end

      end


      def commission_balance
        @agents = Spree::Role.find_by(name: 'commission agent').users
        if params && !params[:balance_as_of].blank?
          params[:balance_as_of] = Time.parse(params[:balance_as_of]).end_of_day rescue ""
        elsif params && params[:balance_as_of].blank?
          params[:balance_as_of] =  Time.now.end_of_day
        end

        @totals = {}
        @agents.each do |agent|
          @totals[agent] = {
              commission_balance: agent.commission_balance_as_of(params[:balance_as_of])
          }
        end
      end

    end
  end
end
