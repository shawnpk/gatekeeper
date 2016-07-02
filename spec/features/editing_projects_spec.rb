require 'rails_helper'

RSpec.feature 'Users can edit existing projects' do
  before do
    FactoryGirl.create(:project, name: 'Atom.io')

    visit root_path
    click_link 'Atom.io'
    click_link 'Edit Project'
  end
  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Atom.io by GitHub'
    click_button 'Update Project'

    expect(page).to have_content 'Project has been updated.'
    expect(page).to have_content 'Atom.io by GitHub'
  end
  scenario 'when providing invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Project'

    expect(page).to have_content 'Project has not been updated.'
  end
end
