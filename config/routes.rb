Rails.application.routes.draw do


  FizzBuzzApp::Application.routes.draw do
    root :to => "users#index"
    resources :users
  end


end