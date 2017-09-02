Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'
          # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
Spree::Core::Engine.routes.draw do
  resources :blogs, only: [:index, :show]
  resources :subscribes, only: :create
  namespace :admin, path: Spree.admin_path do
    resources :blogs do
      collection do
        post :update_positions
      end
    end
    resources :magazines
    resources :mails
    resources :navigations do
      collection do
        post :update_positions
      end
    end
    resources :special_products do
      collection do
        post :update_positions
      end
    end
    resources :special_product_types do
      collection do
        post :update_positions
      end
    end
    resources :sliders do
      collection do
        post :update_positions
      end
    end
  end
end
