# frozen_string_literal: true

namespace :admin do
  # Login and logout for simple auth
  resources :organization, only: %i[index] do
    put '/', to: 'organization#update', on: :collection
  end
  delete '/organization/logo', to: 'organization/logo#destroy'
  post '/organization/logo', to: 'organization/logo#create'
end
