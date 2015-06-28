require 'spec_helper'
require 'pry'

RSpec.describe RailsAdmin::Config::Fields::Types::GlobalizeTabs do
  it 'renders all available locales as tabs' do
    visit '/page/new'
    expect(find('.globalize_tabs_type').find('.nav-tabs')).to have_content 'en cz ru'
  end

  context 'when translated page exists' do
    let!(:translated_page) {
      Page.create!(
        slug: '2001',
        image: 'poster.png',
        title: '2001: Space odyssey',
        content: '<p>Visionary</p>'
      )
    }

    def perform
      visit "/page/#{translated_page.id}/edit"
    end

    describe 'localized data in correct tab' do
      it 'renders the default locale' do
        perform
        within(".localized-pane-en-page-#{translated_page.id}") do
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

        perform

        within(".localized-pane-cz-page-#{translated_page.id}") do
          expect(find_field('Title').value).to eq('2001: Vesmírná odysea')
          expect(find_field('Content')).to have_content('<p>Vizionář</p>')
        end
      end
    end
  end

  it 'works correctly with namespaced models' do
    note = Admin::Note.create(title: 'Fix bug with namespaces', image: 'urgent.png')
    visit "/admin~note/#{note.id}/edit"
    expect(page).to have_css(".localized-pane-en-admin-note-#{note.id}")
  end
end