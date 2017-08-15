Rails.application.routes.draw do
  get '/chat/:id' => 'chat#index'
  
  get '/tips' => 'tips#index'
  get '/tips/card1' => 'tips#card1'
  get '/tips/card2' => 'tips#card2'
  get '/tips/card3' => 'tips#card3'
  
  root "home#home"
  get 'find/id_index'
  get 'find/password_index'
  post 'find/find_id'
  post 'find/find_password'
  post 'users/validate' => 'users#validate'
  post 'users/editvalidate' => 'users#editvalidate'

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
  post 'app/search'
  post 'app/refresh_posts'
  post 'app/get_page'
  post 'app/get_search_page'
  post 'app/refresh_search_posts'
  post 'app/get_post'
  post 'app/write_comment'
  post 'app/delete_comment'
  post 'app/delete_post'
  post 'app/like_toggle'
  post 'app/write_new_post'
  post 'app/enroll_group'
  post 'app/mypage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
