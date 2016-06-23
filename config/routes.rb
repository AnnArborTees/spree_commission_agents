Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :products do
      resources :commission_agents
    end

    resources :users do
      resources :commission_payments do
        collection do
          get :commission_balance
          post :recalculate
        end
      end
    end

    resources :reports, :only => [:index] do
      collection do
        get :commission_total
        post :commission_total
        get :commission_payment_total
        post :commission_payment_total
        get :commission_balance
        post :commission_balance
      end
    end

  end


  resources :commission_reports, only: [:index, :create]
  get 'commission/:start_time...:end_time' => 'commission_reports#show'
  get 'commission' => 'commission_reports#index'

end
