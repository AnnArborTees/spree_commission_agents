require 'spec_helper'

describe Spree::CommissionAgent do
  describe '#effective_rate' do
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

  context '#line_items' do
    it 'returns an array of line_items that have the commission_agent'
  end

  context '#sales' do
    it 'returns sum of the price of the line_items associated with the commission agent between start_time and end_time'

  end

  context '#units_sold' do
    it 'returns sum of the qty of the line_items associated with the commission agent between start_time and end_time'
  end

  context '#commissions_total' do
    it 'returns sum of the commission from the line_items associated with the commission agent between start_time and end_time'
  end

  context '#discounts' do
    it 'returns sum of the adjustments associated with the line_items associated with the commission agent between start_time and end_time'
  end

end
