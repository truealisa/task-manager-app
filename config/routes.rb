Rails.application.routes.draw do
  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    resources :projects do
      resources :tasks
    end
  end

  post 'api/auth/login', to: 'authentication#authenticate'
  post 'api/signup', to: 'users#create'
end
