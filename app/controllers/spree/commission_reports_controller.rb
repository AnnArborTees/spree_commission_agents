module Spree
  class CommissionReportsController < StoreController
    before_filter :validate_commission_agent
    before_filter :assign_user

    def index

    end

    def show

    end

    private

    def assign_user
      @user = spree_current_user
    end

    def validate_commission_agent
      unless spree_current_user.spree_roles.map{|x| x.name }.include? 'commission agent'
        flash[:warning]= "You are not signed up for a commission program."
        redirect_to account_path
      end
    end
  end
end

