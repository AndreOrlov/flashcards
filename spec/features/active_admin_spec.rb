require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'viziting Active Admin page' do
  let(:user) { create(:user) }
  let(:active_admin) {create(:user_admin)}

  before do
    visit root_path
  end

  it 'anounimus user' do
    visit admin_root_path
    expect(current_path).to eq login_path
  end

  it 'simple user' do
    login(user.email, '12345', 'Войти')
    expect(page).to have_content 'Вход выполнен успешно.'
    visit admin_root_path
    expect(current_path).to eq root_path
  end

# TODO Расзобраться, как залогиниться под админом
=begin
  it 'admin user' do
    #user.add_role :admin
    login(active_admin.email, '12345', 'Войти')
    visit admin_root_path
    p admin_root_path
    p current_path
    expect(current_path).to eq admin_root_path
  end
=end

end