# frozen_string_literal: true

namespace :auth do
  # Login and logout for simple auth
  resources :simple_auth, only: %i[create] do
    delete '/', to: 'simple_auth#destroy', on: :collection
  end
end
