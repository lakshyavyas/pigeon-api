# frozen_string_literal: true

Rails.application.routes.draw do
  root 'root#index'
  namespace :api do
    namespace :v1 do
      # File in config/routes/v1/api_simple_auth.rb
      draw 'api_simple_auth', 'v1'
    end
  end
end
