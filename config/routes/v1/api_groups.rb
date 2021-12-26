# frozen_string_literal: true

resources :teams, controller: 'groups/groups', only: %i[create destroy index show update] do
  resources :members, controller: 'groups/group_members', only: %i[create destroy index update]
end

resources :channels, controller: 'groups/groups', only: %i[create destroy index show update] do
  get 'public', to: 'groups/groups#index', on: :collection
  resources :members, controller: 'groups/group_members', only: %i[create destroy index update]
end
