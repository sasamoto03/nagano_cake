class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def show
    @item= Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
     @item = Item.new(item_params)
     @item.save
     redirect_to admin_item_path(@item)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    render :show
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
