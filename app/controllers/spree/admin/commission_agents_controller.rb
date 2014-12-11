module Spree
  module Admin
    class CommissionAgentsController < ResourceController
      belongs_to 'spree/product', :find_by => :slug
      before_filter :load_data

      private

      def load_data
        @product = Spree::Product.friendly.find(params[:product_id])
        @commission_agents = Spree::CommissionAgent.where(product_id: @product.id)
        @users = Spree::Role.find_by(name: 'commission agent').users
      end
    end
  end
end