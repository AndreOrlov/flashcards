require 'rails_helper'

RSpec.describe FlickrController, type: :controller do

  describe "GET #photos" do
    it "returns http success" do
      get :photos
      expect(response).to have_http_status(:success)
    end
  end

end
