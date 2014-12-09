require 'spec_helper'

describe Spree::Variant do

  describe '#comission_for(user)' do

    let(:commission_agent) { create(:percent_commission_agent) }

    context 'a user has commission for a variant' do
      it 'returns the commission amount' do
        product =  commission_agent.product
        user =  commission_agent.user
        expect(product.master.commission_for(user)).to eq(4)  
      end 
    end
  end

  describe '#total_commission' do
    
    context 'a product has multiple commission_agents' do
      let(:commission_agent) { create(:percent_commission_agent) }
      let(:commission_agent_2) { create(:percent_commission_agent) }

      it 'returns the sum of all comissions' do
        product = commission_agent.product
        user = commission_agent.user
        commission_agent_2.update_attributes(product_id: product.id)
        expect(product.master.total_commission).to eq(8)  
      end 
    end

    context 'a product has no commission_agents' do
      let(:product){ create(:product) } 
      
      it 'returns 0' do
        expect(product.master.total_commission).to eq(0)  
      end 
    end

  end
end
