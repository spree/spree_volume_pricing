routes = lambda do
  namespace :admin do 

    resources :products do 
       resources :variants do
        get :volume_price_models, :on => :member
      end
    end

    resources :volume_price_models
    resources :volume_price
    
  end
end

if Spree::Core::Engine.respond_to?(:add_routes)
  Spree::Core::Engine.add_routes(&routes)
else
  Spree::Core::Engine.routes.draw(&routes)
end