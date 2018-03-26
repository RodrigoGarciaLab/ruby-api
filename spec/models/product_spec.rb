require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:product) { FactoryGirl.build :product }
  subject { product }

  it { should respond_to(:name) }
  it { should respond_to(:price) }
  it { should have_many(:order_products) }
  it { should have_many(:orders).through(:order_products) }
end
