# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api, format: :json do
    resource :session, only: %i[show create]
    resources :users, only: :index
    resources :webhooks, only: :update
  end

  root 'home#index'
  get '*path', to: 'home#index', constraints: ->(req) { req.path.exclude?('rails/active_storage') }
end
