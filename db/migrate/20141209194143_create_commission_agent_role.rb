class CreateCommissionAgentRole < ActiveRecord::Migration
  def change
    Spree::Role.where(:name => "commission agent").first_or_create
  end
end
