class Public::AddressesController < ApplicationController
  def new
     @address=Address.new
  end
  def index
    @address=Address.new
    @addresses= current_customer.addresses
  end

  def edit
    @addresses = Address.find(params[:id])
  end

  def create
     @address=Address.new(address_params)
     @address.customer_id = current_customer.id
      if @address.save
         redirect_to addresses_path
      else
        @addresses= current_customer.addresses
        render :index
      end
  end

  def update
    @addresses = Address.find(params[:id])
    if @addresses.update(address_params)
       redirect_to addresses_path
    else
      render :index
    end
  end

  def destroy
    @addresses = Address.find(params[:id])
    @addresses.destroy
    redirect_to '/addresses'
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
