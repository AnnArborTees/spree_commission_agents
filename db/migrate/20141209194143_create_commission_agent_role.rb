class CreateCommissionAgentRole < ActiveRecord::Migration
  def change
    Spree::Role.where(:name => "comission agent").first_or_create
  end
end
