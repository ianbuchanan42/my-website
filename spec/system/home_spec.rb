require 'rails_helper'

RSpec.describe 'Home', type: :system do
  describe 'page content' do
    it 'shows the home page with header text' do
      visit root_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_text('Ian Buchanan')
    end

    it 'displays the main sections' do
      visit root_path
      expect(page).to have_selector('section#about')
      expect(page).to have_selector('section#projects')
    end

    it 'shows the about section with correct content' do
      visit root_path
      within('section#about') do
        expect(page).to have_text('I am a...')
        expect(page).to have_text('Innovative software engineer')
      end
    end

    it 'displays project cards with correct information' do
      visit root_path
      within('section#projects') do
        expect(page).to have_text('Featured Projects')
        expect(page).to have_text('A11y Root')
        expect(page).to have_text('Alt Sprout Dance')
      end
    end
  end

  describe 'navigation' do
    it 'has working navigation links' do
      visit root_path
      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_link('Experience', href: experience_path)
      expect(page).to have_link('About', href: about_path)
      expect(page).to have_link('Contact', href: contact_path)
    end

    it 'highlights the current page in navigation' do
      visit root_path
      expect(page).to have_selector('a[aria-current="page"]', text: 'Home')
    end
  end

  describe 'responsive design' do
    it 'shows mobile menu button on small screens' do
      visit root_path
      expect(page).to have_selector('button[aria-controls="mobile-menu"]')
    end

    it 'displays social links in footer' do
      visit root_path
      within('footer') do
        expect(page).to have_link('Email')
        expect(page).to have_link('GitHub')
        expect(page).to have_link('LinkedIn')
      end
    end
  end

  describe 'accessibility' do
    it 'has proper ARIA labels' do
      visit root_path
      expect(page).to have_selector('nav[aria-label="Main navigation"]')
      expect(page).to have_selector('footer[role="contentinfo"]')
      expect(page).to have_selector('a[aria-label="Home"]')
    end

    it 'has proper heading hierarchy' do
      visit root_path
      expect(page).to have_selector('h2', text: 'I am a...')
      expect(page).to have_selector('h2', text: 'Featured Projects')
    end
  end
end
