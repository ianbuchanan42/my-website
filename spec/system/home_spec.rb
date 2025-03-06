require 'rails_helper'

RSpec.describe 'Home', type: :system do
  it 'shows the home page with welcome message' do
    visit root_path
    expect(page).to have_current_path(root_path)
    expect(page).to have_text('Welcome to My Website')
    expect(page).to have_text('This is a Rails application with RSpec and Selenium testing.')
  end
end
