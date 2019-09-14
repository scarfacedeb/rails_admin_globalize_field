# frozen_string_literal: true

require 'spec_helper'
require 'pry'

module RailsAdminGlobalizeField
  RSpec.describe GlobalizeTabs do
    let(:translated_page) do
      Page.create!(
        slug: '2001',
        image: 'poster.png',
        title: '2001: Space odyssey',
        content: '<p>Visionary</p>'
      )
    end
    let(:note) { Admin::Note.create!(title: 'Fix bug with namespaces') }

    it 'renders all available locales as tabs' do
      visit '/page/new'
      expect(find('.globalize_tabs_type .nav-tabs')).to have_content('en cz ru')
    end

    describe 'localized data in correct tab' do
      it 'renders the default locale' do
        visit "/page/#{translated_page.id}/edit"
        within('#pane-page_translation-en') do
          expect(find_field('Title').value).to eq('2001: Space odyssey')
          expect(find_field('Content')).to have_content('<p>Visionary</p>')
        end
      end

      it 'renders cz locale' do
        Globalize.with_locale(:cz) do
          translated_page.title = '2001: Vesmírná odysea'
          translated_page.content = '<p>Vizionář</p>'
          translated_page.save!
        end

        visit "/page/#{translated_page.id}/edit"

        within('#pane-page_translation-cz') do
          expect(find_field('Title').value).to eq('2001: Vesmírná odysea')
          expect(find_field('Content')).to have_content('<p>Vizionář</p>')
        end
      end
    end

    it 'works correctly with namespaced models' do
      visit "/admin~note/#{note.id}/edit"
      expect(page).to have_css('#pane-admin_note_translation-en')
    end

    it 'allows to set custom label name for translated attribute' do
      visit "/admin~note/#{note.id}/edit"
      within('#pane-admin_note_translation-en') do
        expect(find('#admin_note_translations_attributes_0_title_field')).to have_content('Custom note title')
      end
    end
  end
end
