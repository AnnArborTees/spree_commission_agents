Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :products do
      resources :commission_agents
    end
  end
end
