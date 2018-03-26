class OrderProductsController < ApplicationController
  before_action :set_order
  before_action :correct_user
  before_action :set_order_item, only: [:read, :update, :destroy]
  
  def create
    @order.order_products.create!(item_params)
    json_response(@order, :created)
  end

  def read
    json_response(@item)
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def delete
    @item.destroy
    head :no_content
  end

  private

    def item_params
      params.permit(:product_id, :quantity)
    end

    def set_order
      @order = Order.find(params[:order_id])
    end

    def set_order_item
      @item = @order.order_products.find_by!(id: params[:id]) if @order
    end

    def correct_user
      json_response({ message: Message.unauthorized }, :unauthorized) unless current_user.id == @order.created_by || current_user.admin?
    end
end
