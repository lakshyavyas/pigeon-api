# frozen_string_literal: true

namespace :iam do
  # User profile
  resources :me, only: %i[index] do
    put '/', to: 'me#update', on: :collection
  end
  resources :avatar, only: %i[create] do
    delete '/', to: 'avatar#destroy', on: :collection
  end
  resources :organization, only: %i[index]
end
