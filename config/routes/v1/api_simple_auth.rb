# frozen_string_literal: true

# Login and logout for simple auth
resources :simple_auth, only: %i[create destroy]
