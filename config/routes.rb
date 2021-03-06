Chamomile::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :api do
    get '/pages/recent.:format', to: 'pages#recent'
    get '/templates/recent.:format', to: 'templates#recent'
  end

  #resources :wiki
  get '/wiki', to: 'wiki#index'
  get '/wiki/new', to: 'wiki#new'
  post '/wiki', to: 'wiki#create'
  get '/wiki/:slug/edit', to: 'wiki#edit'
  put '/wiki/:slug', to: 'wiki#update'
  delete '/wiki/:slug', to: 'wiki#destroy'

  get '/wiki/:wiki_slug', to: 'pages#index'
  get '/wiki/:wiki_slug/list', to: 'pages#list'
  get '/wiki/:wiki_slug/new', to: 'pages#new'
  post '/wiki/:wiki_slug', to: 'pages#create'
  get '/wiki/:wiki_slug/:flagment', to: 'pages#show'
  get '/wiki/:wiki_slug/:flagment/edit', to: 'pages#edit'
  put '/wiki/:wiki_slug/:flagment', to: 'pages#update'
  patch '/wiki/:wiki_slug/:flagment', to: 'pages#update'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
