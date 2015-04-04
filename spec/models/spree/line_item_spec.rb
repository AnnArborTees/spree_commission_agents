require 'spec_helper'

describe Spree::LineItem do

  context '#assign_commissions' do
    let(:order) { create :order_with_line_items, line_items_count: 1 }
    let(:line_item) { order.line_items.first }
    let!(:commission_agent) { create(:flat_commission_agent, product: line_item.variant.product)}

    it 'creates a commission for every commission agent associated with the line_item#variant' do
      line_item.assign_commissions
      expect(line_item.commissions).to_not be_empty
    end
  end

end

