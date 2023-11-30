class Public::CartItemsController < ApplicationController
  def index
    @cart_items=CartItem.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    @cart_items.destroy
    redirect_to cart_items_path
  end

  def clear
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item=CartItem.new
    @cart_item.item_id = cart_item_params[:item_id]
    @cart_item.customer_id = current_customer.id
    @cart_item.amount = cart_item_params[:amount]
    @cart_items=current_customer.cart_items.all
    @cart_items.each do |cart_item|
    if  cart_item.item_id==@cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
    end
    end
    @cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end