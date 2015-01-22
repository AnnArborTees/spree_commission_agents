module Spree
  class CommissionReportsController < StoreController
    before_filter :validate_commission_agent
    before_filter :assign_user

    def index

    end

    def show
      respond_to do |format|
        format.html { render }
        format.csv { render layout: nil }
      end
    end

    def create
      redirect_to commission_agent_report_path(start_time: params[:start_time],
                                   end_time: params[:end_time])
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

