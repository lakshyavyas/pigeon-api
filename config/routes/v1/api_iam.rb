# frozen_string_literal: true

namespace :iam do
  # User profile
  resources :me, only: %i[index]
end
