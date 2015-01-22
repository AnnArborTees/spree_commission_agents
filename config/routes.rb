Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :products do
      resources :commission_agents
    end

    resources :reports, :only => [:index] do
      collection do
        get :commission_total
        post :commission_total
      end
    end

  end


  resources :commission_reports, only: [:index, :create]
  get 'commission/:start_time...:end_time' => 'commission_reports#show', as: :pretty_commission_report
  get 'commission' => 'commission_reports#index'

end
