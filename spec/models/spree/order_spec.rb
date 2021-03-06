# encoding: utf-8

require 'spec_helper'

class FakeCalculator < Spree::Calculator
  def compute(computable)
    5
  end
end

describe Spree::Order do
  let(:user) { stub_model(Spree::LegacyUser, :email => "spree@example.com") }
  let(:order) { stub_model(Spree::Order, :user => user) }

  before do
    Spree::LegacyUser.stub(:current => mock_model(Spree::LegacyUser, :id => 123))
  end

  context "#finalize!", pending: 'TODO: I either need to learn how to properly call the after_transition
                                   or how to test it' do
    let(:order) { Spree::Order.create(email: 'test@example.com') }

    before do
      order.update_column :state, 'complete'
    end

    it "sets creates commission for commission agent products" do

      order.should_receive(:create_commissions)
      order.finalize!
    end
  end

  context '#create_commissions' do
    it 'assigns commission values to all line items that have associated commission_agents'
  end


end