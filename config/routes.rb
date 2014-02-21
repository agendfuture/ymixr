YoumixrOR::Application.routes.draw do

  root :to => "static_pages#home"

  get "home", to: "static_pages#home"
  get "help", to:  "static_pages#help"
  get "run", to: "static_pages#run"

  get "log_out" => "sessions#destroy", as: :log_out
  get "session", to: "static_pages#index"
  resource :sessions
  
  resources :histories, :only => [:delete, :show]

  resources :users, constraints: {id: /\d+/}, except: [:index] do 
    resources :histories, only: [:index]
    member do
      get 'playlists', to: 'users#playlists', constraints: {id: /\d+/}
    end
  end

  resources :playlists, constraints: {id: /\d+/} do
    member do
      get 'select'
    end

    collection do
      get 'addSong/:sid', to: 'playlist_entries#create', constraints: {sid: /yt:(\w|-)+|sc:\d+|vi:\d+/}
      get 'removeSong/:playlist_entry_id', to: 'playlist_entries#destroy', constraints: {playlist_entry_id: /\d+/}
      get 'reorder/:playlist_entry_id/:next_playlist_entry_id', 
          to: 'playlist_entries#reorder', constraints: {playlist_entry_id: /\d+/, next_playlist_entry_id: /\d+/}
      get 'reorder/:playlist_entry_id', 
          to: 'playlist_entries#reorder', constraints: {playlist_entry_id: /\d+/}
    end

    resources :playlist_entries, only: [:destroy, :create], constraints: {id: /\d+/} do
      post 'add', to: :create
      delete 'remove', to: :destroy 
    end
  end
  
  get '/songs/soundcloudTemplate', to: "songs#soundcloudTemplate"

  resources :songs, constraints: {id: /yt:(\w|-)+|sc:\d+|vi:\d+/} do  
    member do 
      get 'play'
    end
    collection do
      get "search"
    end
  end

  resources :vimeo, controller: :vimeo_wrappers, only: [:index]

end
