require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build :order }
  let(:product_1) {create(:product)}
  let(:product_2) {create(:product)}
  
  describe "Basic validations" do
    it { should respond_to(:total) }
    it { should respond_to(:created_by) }

    it { should validate_presence_of :created_by }
    it { should have_many(:order_products) }
    it { should have_many(:products).through(:order_products) }
  end

  describe "#build_order_with_product_ids_and_quantities" do
    before(:each) do
      

      @product_ids_and_quantities = [[product_1.id, 2], [product_2.id, 3]]
    end

    it "builds 2 order products for the order" do
      expect{order.build_order_with_product_ids_and_quantities(@product_ids_and_quantities)}.to change{order.order_products.size}.from(0).to(2)
    end
  end

end
