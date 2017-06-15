# Entire routes.rb is calling draw method with do-end block
SampleApp::Application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations' }

  # From API: resources(*resources, &block)
  # * called splat operator. It indicates that mrore parameters may be passed to the function.
  # And those parameters are collected up and an array is created.
  # do...end or {} is called "block" which contains several lines of code and can be executed with "yield".
  # do...end for multi-lines blocks and {} for single line blocks
  # block is associated with method invocation. 
  # e.g. greet {put 'Hello'} invokes a call to greet method with block {put 'Hello'}.
  # Basically, when you create a method, you can have several yield statement. 
  # Then if you invoke that method with blcok, the block is executed.

  resources :sessions, only: [:new, :create, :destroy]
  resources(:microposts) do
    post :vote, on: :member
    delete :delete, on: :member
  end
  
  resources :users

  resources :password_resets
  
  root to: 'static_pages#home'
  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/sendmessage', to: 'microposts#new'
  get '/help',    to: 'users#help'
  delete '/removepost', to: 'microposts#destroy'
end