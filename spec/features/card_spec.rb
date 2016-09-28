require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'New card' do
  let(:user) { create(:user) }
  let!(:block) { create(:block, user: user) }

  before :each do
    visit root_path
    begin
      login(user.email, '12345', 'Войти')
    rescue
    # TODO If Selenium driver (firefox, travisCI w PhantomJS v.1.9) login in en locale. It's bug
      login(user.email, '12345', 'Log in')
    end
    visit new_card_path
    fill_in 'card_original_text', with: 'house'
    fill_in 'card_translated_text', with: 'dom'
    select block.title, from: 'card_block_id'
  end

  it 'wo image' do
    click_button 'Сохранить'
    expect(page).to have_content 'Create new card wo image.'
  end

  it 'with local image' do
    # file = create(:attachment)
    attach_file('file_image', File.join(fixture_path, 'local_pic.jpg'))
    click_button 'Сохранить'
    expect(page).to have_content 'Create new card with local image.'
  end

=begin
  it 'with remote image', js: true do
    VCR.use_cassette('flickr_service_post') do
      find(:css, '#find_flickr').click # set(true)
      fill_in 'search-term', with: 'test'
      Capybara.default_max_wait_time = 60
      # TODO TravisCI not passed this ajax w PhantomJS driver:(
      find(:css, '#search_flickr').click
      wait_for_ajax
      find(:css, '#remote-pic-5').click
      click_button 'Сохранить'
      expect(page).to have_content 'Create new card with remote image.'
    end
  end
=end
end
