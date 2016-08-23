require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'viziting Active Admin page' do
  let(:user) { create(:user) }
  let(:admin) {create(:user_admin)}

  before do
    visit root_path
  end

  it 'anounimus user' do
    visit admin_root_path
    expect(current_path).to eq root_path
  end

  it 'simple user' do
    login(user.email, '12345', 'Войти')
    expect(page).to have_content 'Вход выполнен успешно.'
    visit admin_root_path
    expect(current_path).to eq root_path
  end

  it 'admin user' do
    login(admin.email, '12345', 'Войти')
    visit admin_root_path
    expect(current_path).to eq admin_root_path
  end

end