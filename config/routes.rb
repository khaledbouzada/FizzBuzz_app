Rails.application.routes.draw do

  FizzBuzzApp::Application.routes.draw do
    root :to => "users#index"
    # http://localhost:3333/users/1/index?page=1000
    get '/users/:id/index', :to => 'users#index'

    resources :users do
      post :index

    end
  end


end
