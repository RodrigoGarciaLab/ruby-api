require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe "GET #show" do
    before { get "/users/#{user.id}",  params: {}, headers: headers }

    it "returns the information about a reporter on a hash" do
      expect(json["email"]).to eql user.email
    end

    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
