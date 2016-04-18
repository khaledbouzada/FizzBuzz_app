Rails.application.routes.draw do

  FizzBuzzApp::Application.routes.draw do
    root :to => "users#index"
    get '/users/:id/index', :to => 'users#index'
    resources :users do
      post :index
    end
  end
end
