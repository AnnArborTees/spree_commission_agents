# encoding: utf-8

require 'spec_helper'

describe Spree::User do
  let(:order) { create :order_with_line_items, line_items_count: 1 }
  let(:product) { order.line_items.first.product }
  let(:commission_agent) { create(:percent_commission_agent, product: product) }
  let(:user) { commission_agent.user }

  context '#commissions_total' do

    before do
      commission_agent.touch
      order.update_column :state, 'complete'
    end

    it 'returns the sum of commissions.amount of the commission_agent line_items for completed orders' do
      order.finalize!
      expect(user.commissions_total).to eq(4)
    end
  end

  context '#adjustment_total' do
    it 'returns the sum of adjustment.totals of the commission_agent line_items for completed orders'
  end

  context '#sales_total' do

    before do
      commission_agent.touch
      order.update_column :state, 'complete'
    end

    it 'returns a sum of commissonable products that have been purchased' do
      order.finalize!
      expect(user.commission_agents).to_not be_empty
      expect(Spree::Order.first.line_items.first.variant.product).to eq(product)
      expect(Spree::Order.first.item_total.to_f).to eq(10)
      expect(Spree::Order.first.line_items.count).to eq(1)
      expect(Spree::Order.first.line_items.first.quantity).to eq(1)
    end
  end

  context 'comission_products' do
    it 'returns the sum of line_items.price of the commission_agent line_items for completed orders' do
      expect(user.commission_products).to eq([product])
    end
  end


end