require 'spec_helper'

feature 'Commission Payments' do
  stub_authorization!

  let!(:user) { create(:user_with_addreses, email: 'a@example.com') }

  background(:each) do
    visit spree.admin_path
  end

  feature 'as an admin with valid credentials, I can', admin: true, js: true do

    scenario 'I can make a commission payment' do
      click_link 'Users'
      find("spree_user_#{user.id} .fa-edit").click
      click_link 'Commission payments'
      # Click commission payments
      # click "New Commission Payment"
      # It populates with the current balance by default
      # Click "Make Payment"
    end

    scenario 'I can report on how much a commission agent is owed through a date via their user screen'
      # visit a user path
      # Click commission payments
      # click "New Commission Payment"
      # It populates with the current balance by default
      # Click "Make Payment"


  end


end