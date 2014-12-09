module Spree
  Variant.class_eval do
    has_many :commission_agents, through: :product

    def commission_for(user)
      commission_agents.where(user_id: user.id).map{ |x| x.effective_rate}.sum
    end

    def total_commission
      commission_agents.map{|x| x.effective_rate }.sum
    end

  end
end