module Spree
  module Admin
    Reports.class_eval do

      def initialize
        super
        ReportsController.add_available_report!(:commission)
      end


    end
  end
end