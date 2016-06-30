require 'rails_helper'

RSpec.feature 'Users can create new projects' do
  scenario 'with valid attributes' do
    visit '/'

    click_link 'New Project'

    fill_in 'Name', with: 'Atom.io'
    fill_in 'Description', with: 'An IDE created by GitHub'
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'

    project = Project.find_by(name: 'Atom.io')
    expect(page.current_url).to eq project_url(project)

    title = 'Atom.io - Projects - GateKeeper'
    expect(page).to have_title title
  end
end
