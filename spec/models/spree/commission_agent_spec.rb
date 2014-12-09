require 'spec_helper'

describe Spree::CommissionAgent do
  describe '#product_commission' do 
    context 'rate is a percentage' do 
      let(:commission_agent) {create(:percent_commission_agent)}
      
      it 'returns the product price * the rate as a percent' do 
        expect(commission_agent.effective_rate).to eq(4)
      end
    end

    context 'rate is a percentage with a maximum' do 
      let(:commission_agent) {create(:percent_with_max_one)}
      
      it 'returns base commission or max, whichever is less' do 
        expect(commission_agent.effective_rate).to eq(1)
      end
    end

    context 'rate is a percentage with a minimum' do 
      let(:commission_agent) {create(:percent_with_min_five)}
      
      it 'returns base commission or max, whichever is less' do 
        expect(commission_agent.effective_rate).to eq(5)
      end
    end
  end

  describe '#product_commission' do 
    context 'rate is a percentage' do 
      let(:commission_agent) {create(:flat_commission_agent)}
      
      it 'returns the product price * the rate as a percent' do 
        expect(commission_agent.effective_rate).to eq(7)
      end
    end
  end
end
