# frozen_string_literal: true

def app_config
  Rails.application.config_for :app_config
end

def mask_value(value)
  ScatterSwap.hash(value).to_i
end

def unmask_value(value)
  ScatterSwap.reverse_hash(value).to_i
end
