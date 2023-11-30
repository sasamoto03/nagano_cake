Rails.application.routes.draw do


  scope module: :public do
    root'homes#top'
    get'customers/edit'=>'customers#edit'
    get'customers/my_page'=>'customers#show'
    patch'customers/information'=>'customers#update'
    get'customers/unsubscribe'=>'customers#unsubscribe'
    patch'customers/withdraw'=>'customers#withdraw'
    resources :items, only: [:index, :show]
    delete'cart_items/destroy_all'=>'cart_items#clear'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get'orders/complete'=>'orders#complete'
    resources :orders, only: [:new, :index, :show, :create]
    post'orders/confirm'=>'orders#confirm'
    resources :addresses, only: [:new, :index, :edit, :create, :update, :destroy]
    get'about'=>'homes#about'
    resources :registrations, only: [:new]
  end

  namespace :admin do
    root'homes#top'
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end
  # For detailson the DSL available within this file, see https://guides.rubyonrails.org/routing.html
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
end
