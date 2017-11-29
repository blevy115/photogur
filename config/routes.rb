Rails.application.routes.draw do
  get 'sessions/new'

  post 'sessions/create'

  delete 'sessions' => 'sessions#destroy'

  # get 'users/new'
  #
  # get 'users/create'

  root 'pictures#index'
  get 'pictures' => 'pictures#index'

  post 'pictures' => 'pictures#create'
  get 'pictures/new' => 'pictures#new'

  get 'pictures/:id' => 'pictures#show'

  get 'pictures/:id/edit' => 'pictures#edit'
  patch 'pictures/:id' => 'pictures#update'

  delete 'pictures/:id' => 'pictures#destroy'

  resource :users, only: %i(create new)
end
