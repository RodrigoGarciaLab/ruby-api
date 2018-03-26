class ProductsController < ApplicationController
  before_action :authorize_admin_request, only: [:create, :update, :delete]
  skip_before_action :authorize_request,  only: [:index, :show]
  
  def index
    @products = Product.all
    json_response(@products)
  end

  def create
    @product = Product.create!(product_params)
    json_response(@product, :created)
  end

  def show
    json_response(Product.find(params[:id]))
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    head :no_content
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    head :no_content
  end

  private

    def product_params
      params.require(:product).permit(:name, :price, :image_url)
    end

end
