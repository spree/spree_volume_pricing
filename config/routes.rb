Spree::Core::Engine.add_routes do
  namespace :admin do

    resources :products do
       resources :variants do
        get :volume_price_models, on: :member
      end
    end

    resources :volume_price_models
    resources :volume_price
    
  end
end
