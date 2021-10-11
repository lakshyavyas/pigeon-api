# frozen_string_literal: true

# Functions that will be used by multiple test cases
module SharedFunctions
  attr_accessor :user, :access, :api_user

  def given_admin_user
    @user = FactoryBot.create(:simple_auth_admins)
    expect(user.first_name).not_to eq(nil)
    expect(user.last_name).not_to eq(nil)
    expect(user.email).not_to eq(nil)
    expect(user.simple_auth).not_to eq(nil)
  end

  def given_normal_user
    @user = FactoryBot.create(:simple_auth_users)
    expect(user.first_name).not_to eq(nil)
    expect(user.last_name).not_to eq(nil)
    expect(user.email).not_to eq(nil)
    expect(user.simple_auth).not_to eq(nil)
  end

  def given_logged_in_admin
    given_admin_user
    @access = user.accesses.create(token_type: :api)
  end

  def given_logged_in_normal_user
    given_normal_user
    @access = user.accesses.create(token_type: :api)
  end

  def given_other_user
    @other_user = FactoryBot.create(:simple_auth_users)
  end

  def given_fake_other_user
    user_struct = Struct.new(:obj_id)
    @other_user = user_struct.new(1231)
  end

  def given_logged_in_other_user
    given_other_user
    @access = user.accesses.create(token_type: :api)
  end

  def user_able_to_login
    post '/api/v1/auth/simple_auth', params: { username: user.email, password: user.simple_auth.password }
    expect(response.status).to eq(201)
    @access = JSON.parse(response.body, symbolize_names: true)
    expect(access[:access_token]).not_to eq(nil)
    expect(access[:renew_token]).not_to eq(nil)
    expect(access[:expires_at]).not_to eq(nil)
  end

  def user_able_fetch_profile
    get '/api/v1/iam/me', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    @api_user = JSON.parse(response.body, symbolize_names: true)
    expect(api_user[:first_name]).not_to eq(nil)
    expect(api_user[:last_name]).not_to eq(nil)
    expect(api_user[:full_name]).not_to eq(nil)
  end

  def user_able_to_logout
    delete '/api/v1/auth/simple_auth', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
  end

  def first_name
    'first_name'
  end

  def last_name
    'last_name'
  end

  def default
    'Default'
  end

  def uploaded
    'Uploaded'
  end
end
