require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  let(:user) { create(:user) }
  let!(:orders) { create_list(:order, 10, created_by: user.id) }
  let(:headers) { valid_headers }
  let(:order) { orders.first }
  let(:order_id) { orders.first.id }
  let(:product_1) {create(:product)}
  let(:product_2) {create(:product)}

  describe 'GET /orders' do
    # make HTTP get request before each example
    before { get '/orders',  params: {}, headers: headers }

    it 'returns orders' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before { get "/orders/#{order_id}",  params: {}, headers: headers }
    context 'when the record exists' do
      it "returns the user order record matching the id" do
        expect(json["id"]).to eql order.id
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:order_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end

  end

  describe "POST #create" do
    before(:each) do
      product_ids_and_quantities = [[product_1.id, 2], [product_2.id, 3]]
      order_params = { user_id: user.id, product_ids_and_quantities: product_ids_and_quantities }
      string_params = '{ "order": { "user_id":"%{user.id}" , "product_ids_and_quantities": [[1,2],[2,3]] } }'
      post "/orders", :params => string_params, :headers => headers

    end

    it "returns the just user order record" do
      expect(json["id"]).to be_present
    end
    it 'returns status code 201' do
        expect(response).to have_http_status(201)
    end
  end

end
