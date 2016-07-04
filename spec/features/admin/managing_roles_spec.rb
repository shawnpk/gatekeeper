require 'rails_helper'

RSpec.feature 'Admin can manage a user\'s roles' do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user)  { FactoryGirl.create(:user) }

  let!(:safari) { FactoryGirl.create(:project, name: 'Safari') }
  let!(:atom)   { FactoryGirl.create(:project, name: 'Atom.io') }

  before do
    login_as(admin)
  end

  scenario 'when assigning roles to an existing user' do
    visit admin_user_path(user)
    click_link 'Edit User'

    select 'Viewer',  from: 'Safari'
    select 'Manager', from: 'Atom.io'

    click_button 'Update User'
    expect(page).to have_content 'User has been updated'

    click_link user.email
    expect(page).to have_content 'Safari: Viewer'
    expect(page).to have_content 'Atom.io: Manager'
  end

  scenario 'when assigning roles to a new user' do
    visit new_admin_user_path

    fill_in 'Email', with: 'newuser@gatekeeper.com'
    fill_in 'Password', with: 'password'

    select 'Editor', from: 'Safari'
    click_button 'Create User'

    click_link 'newuser@gatekeeper.com'
    expect(page).to have_content 'Safari: Editor'
    expect(page).not_to have_content 'Atom.io'
  end
end
