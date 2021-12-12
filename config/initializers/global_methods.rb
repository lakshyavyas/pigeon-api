# frozen_string_literal: true

def app_config
  Rails.application.config_for :app_config
end

def roles_config
  Rails.application.config_for :roles_config
end
