class Admin::OrdersController < ApplicationController
  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end
end
