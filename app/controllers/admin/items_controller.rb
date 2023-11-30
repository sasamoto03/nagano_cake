class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def create
     @item = Item.new(item_params)
     @item.save
    redirect_to admin_item_path(@item)
  end

  def update
    @item = Item.new
    @item.update(item_params)
    redirect_to dmin_item_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
end
