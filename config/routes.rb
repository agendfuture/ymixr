YoumixrOR::Application.routes.draw do

  root :to => "static_pages#home"

  match "home", to: "static_pages#home"
  match "help", to:  "static_pages#help"
  match "run", to: "static_pages#run"

  get "log_out" => "sessions#destroy", as: :log_out
  match "session", to: "static_pages#index"
  
  delete '/histories/:id' => 'histories#destroy'

  #match "/users", to: redirect('/run')
  get '/users/show', to: 'users#show'
  get '/users/:id', to: 'users#index', constraints: {id: /\d+/}
  resources :users

  resource :sessions

  get '/playlist/addSong/:sid', to: 'playlist_entries#create', constraints: {sid: /yt:(\w|-)+|sc:\d+/}
  get '/playlist/removeSong/:sid/:order', to: 'playlist_entries#remove', constraints: {sid: /yt:(\w|-)+|sc:\d+/, order: /\d+/}

  resources :playlists, constraints: {id: /\d+/} do
    member do
      get 'add/:sid/:order', to: :add, constraints: {sid: /yt:(\w|-)+|sc:\d+/, oder: /\d+/}
      get 'remove/:sid/:order', to: :remove, constraints: {sid: /yt:(\w|-)+|sc:\d+/, order: /\d+/}
      get 'add/:sid', to: :add, constraints: {sid: /yt:(\w|-)+|sc:\d+/}
      get 'remove/:sid', to: :remove, constraints: {sid: /yt:(\w|-)+|sc:\d+/}
      get 'add'
      get 'remove'
      get 'select'
    end

    resources :playlist_entries, only: [:destroy, :create] do
      post 'add', to: :create
      delete 'remove', to: :destroy 

    end
  end
  
  match '/songs/soundcloudTemplate', to: "songs#soundcloudTemplate"

  resources :songs, constraints: {id: /yt:(\w|-)+|sc:\d+/} do  
    member do 
      get 'play'
    end
    collection do
      get "search"
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
