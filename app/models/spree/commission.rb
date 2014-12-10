module Spree
  class Commission < ActiveRecord::Base
    belongs_to :commission_agent
    belongs_to :line_item
    
  end
end
