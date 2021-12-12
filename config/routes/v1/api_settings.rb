# frozen_string_literal: true

namespace :settings do
  resources :organization, only: %i[index] do
    put '/', to: 'organization#update', on: :collection
  end
  post '/organization/logo', to: 'organization_logo#create'
  delete '/organization/logo', to: 'organization_logo#destroy'
end
