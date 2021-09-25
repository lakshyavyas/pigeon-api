# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Simple Auths', type: :request, feature: true do
  it 'able to login' do
    given_the_user
    user_able_to_login
    user_able_fetch_profile
    error_with_invalid_credentials
  end

  it 'able to logout' do
    given_the_user
    user_able_to_login
    user_able_to_logout
    user_able_to_login
    error_if_some_error
  end

  def error_if_some_error
    allow_any_instance_of(Access).to receive(:update).and_return(false)
    delete '/api/v1/auth/simple_auth', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(500)
  end

  def error_with_invalid_credentials
    post '/api/v1/auth/simple_auth', params: { username: user.email, password: SecureRandom.hex(20) }
    expect(response.status).to eq(400)
  end
end
