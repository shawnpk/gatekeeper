require 'rails_helper'

RSpec.feature 'Users can create new projects' do
  before do
    visit '/'

    click_link 'New Project'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Atom.io'
    fill_in 'Description', with: 'An IDE created by GitHub'
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'

    project = Project.find_by(name: 'Atom.io')
    expect(page.current_url).to eq project_url(project)

    title = 'Atom.io - Projects - GateKeeper'
    expect(page).to have_title title
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Project'

    expect(page).to have_content 'Project has not been created.'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
