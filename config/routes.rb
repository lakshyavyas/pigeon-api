# frozen_string_literal: true

Rails.application.routes.draw do
  root 'root#index'
  namespace :api do
    namespace :v1 do
      draw 'api_auth', 'v1' # config/routes/v1/api_auth.rb
      draw 'api_iam', 'v1' # config/routes/v1/api_iam.rb
      draw 'api_admin_organization', 'v1' # config/routes/v1/api_admin_organization.rb
    end
  end
end
