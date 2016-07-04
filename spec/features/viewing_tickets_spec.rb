require 'rails_helper'

RSpec.feature 'Users can view tickets' do
  before do
    author = FactoryGirl.create(:user)

    atom = FactoryGirl.create(:project, name: 'Atom.io')
    assign_role!(author, :viewer, atom)
    FactoryGirl.create(:ticket, project: atom,
                                author: author,
                                name: 'Make it shiny!',
                                description: 'Gradients! Starbursts! Oh my!')

    safari = FactoryGirl.create(:project, name: 'Safari')
    assign_role!(author, :viewer, safari)
    FactoryGirl.create(:ticket, project: safari,
                                author: author,
                                name: 'Standards compliance',
                                description: 'Isn\'t a joke!')

    login_as(author)
    visit root_path
  end
  scenario 'for a given project' do
    click_link 'Atom.io'

    expect(page).to have_content 'Make it shiny!'
    expect(page).to_not have_content 'Standards compliance'

    click_link 'Make it shiny!'
    within('#ticket h2') do
      expect(page).to have_content 'Make it shiny!'
    end

    expect(page).to have_content 'Gradients! Starbursts! Oh my!'
  end
end
