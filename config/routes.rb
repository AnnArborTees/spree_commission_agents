Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :products do
      resources :commission_agents
    end
  end

  get 'commission' => 'commission_reports#index'
  get 'commission/:start_time...:end_time' => 'commission_reports#show'

end
