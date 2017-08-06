Rails.application.routes.draw do
  get '/chat/:id' => 'chat#index'
  
  get '/tips' => 'tips#index'
  get '/tips/card1' => 'tips#card1'
  
  root "home#home"
  get 'find/id_index'
  get 'find/password_index'
  post 'find/find_id'
  post 'find/find_password'
  post 'users/validate' => 'users#validate'

  get '/admin' => 'admin#index'
  post '/admin' => 'admin#mail_send'
  get '/admin/matching' =>'admin#matching'

  get 'setting/index'

  get 'home/index'
  get 'home/home'
  
  resources :sessions, only: [:new, :create, :destroy]

  resources :posts do
      post "/like", to: "likes#like_toggle"
      resources :comments, only: [:create, :destroy]
  end
  
  resources :users do
    member do
      get :confirm_email
    end
  end
  
  get 'users/new' => 'users#new'
  get 'setting/index'

  get 'home/index'
  
  resources :groups
  post 'groups/validate' => 'groups#validate'
  resources :meetings
  #resources :contact, only: [:new, :create], path_names: { new: "" }
  resources :sessions, only: [:new, :create, :destroy]


  # For App
  post 'app/login' => 'app#login'
  post 'app/meetings'
  post 'app/signup'
  post 'app/checkuniq'
  post 'app/checkcompanion'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
