require 'spec_helper'

RSpec.describe RailsAdmin::Config::Fields::Types::GlobalizeTabs do
  it 'renders all available locales as tabs' do
    visit '/page/new'
    expect(find('.globalize_tabs_type').find('.nav-tabs')).to have_content 'en cz ru'
  end
end