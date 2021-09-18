# frozen_string_literal: true

# Tokenable module for model which have access_token and renew_token
module Tokenable
  extend ActiveSupport::Concern

  included do
    before_validation :gen_access_token, :gen_renew_token, :gen_expires_at
  end

  protected

  def gen_access_token
    return if access_token

    self.access_token = loop do
      random_token = "at-#{SecureRandom.hex(16)}"
      break random_token unless self.class.exists?(access_token: random_token)
    end
  end

  def gen_renew_token
    return if renew_token

    self.renew_token = loop do
      random_token = "rt-#{SecureRandom.hex(16)}"
      break random_token unless self.class.exists?(renew_token: random_token)
    end
  end

  def gen_expires_at
    return if expires_at

    val = app_config[:access][:duration][:api]
    self.expires_at = Time.now.since(val)
  end
end
