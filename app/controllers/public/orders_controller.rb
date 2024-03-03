class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
    @customer=current_customer
  end

  def confirm
    @order = Order.new(order_params)
   if params[:order][:payment_method] =="credit_card"
     @order.payment_method = 0
   end
   if params[:order][:payment_method] =="transfer"
     @order.payment_method = 1
   end
   if params[:order][:address_select_id]=="0"
     @order.address = current_customer.address
     @order.postal_code = current_customer.postal_code
     @order.name = current_customer.last_name + current_customer.first_name
     @order.customer_id = current_customer.id
     #@cart_items = current_customer.cart_items
   end
   if params[:order][:address_select_id]=="1"
      @address=Address.find(params[:order][:address_id])
      @order.address= @address.address
      @order.postal_code= @address.postal_code
      @order.name= @address.name
      @order.customer_id= @address.customer_id
   end
   @cart_items = current_customer.cart_items.all
  end

  def complete
    CartItem.destroy_all
  end

  def index
    @orders = Order.all
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  def create
    @order=current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!

    current_customer.cart_items.each do |cart_item| #カート内商品を1つずつ取り出しループ
     @order_detail = OrderDetail.new #初期化宣言
     @order_detail.order_id = @order.id #order注文idを紐付けておく
     @order_detail.item_id = cart_item.item_id #カート内商品idを注文商品idに代入
     @order_detail.quantity = cart_item.amount #カート内商品の個数を注文商品の個数に代入
     @order_detail.add_tax_price = (cart_item.item.price*1.08).floor #消費税込みに計算して代入
    @order_detail.save! #注文商品を保存
 end #ループ終わり

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to orders_complete_path
  end

  def update
    @orders = Order.find(params[:id])
   if @order.update(order_params)
      redirect_to order_path(@order.id)
   else
      render :index
   end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :total_amount, :postage)
  end
end
