Rails.application.routes.draw do


  get 'example/form'

  get 'home/index'

  root 'home#index'
  resources :locations do
    resources :events
  end

  get 'example/form' => 'example#form'
  resources :job_applications

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
