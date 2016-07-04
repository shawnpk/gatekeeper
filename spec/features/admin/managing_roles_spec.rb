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
end
