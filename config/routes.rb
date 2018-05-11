Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }


  root to: 'home_pages#index'

  get 'policy', to: 'home_pages#policy'
  get 'terms', to: 'home_pages#terms'

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    post 'login', to: 'auth#login'
    post 'logout', to: 'auth#logout'

    resources :events
  end

end
