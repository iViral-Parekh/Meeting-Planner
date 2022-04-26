Rails.application.routes.draw do
  devise_for :employees
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
  resources :employee, only: %i[index] do
    post :opt_in
  end
  resources :blind_dates, only: %i[create update] do
    collection do
      get :groups
    end
  end
end
