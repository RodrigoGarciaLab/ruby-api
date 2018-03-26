class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :correct_user,   only: [:update]
  before_action :authorize_admin_request, only: [:show, :index, :update, :delete]

  def index
    @orders = current_user.orders.paginate(page: params[:page], per_page: 10)
    json_response(@orders)
  end

  def create
    puts "REACHES CREATE ORDER ---------"
    order = current_user.orders.create!
    order.build_order_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])
    order.save
    json_response(order, :created)
  end

  def show
    json_response(@order)
  end

  def update
    @order.update(order_params)
    head :no_content
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def correct_user
      json_response({ message: Message.unauthorized }, :unauthorized) unless current_user.id == @order.created_by || current_user.admin?
    end

    def order_params
      params.require(:order).permit(
        :id,
        :sent
      )
    end
end
