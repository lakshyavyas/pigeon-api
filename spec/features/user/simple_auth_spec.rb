# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User - Simple Auths', type: :request, feature: true do
  it 'able to login' do
    given_the_user
    user_able_to_login
    user_able_fetch_profile
  end

  it 'able to logout' do
    given_the_user
    user_able_to_login
    user_able_to_logout
  end
end
