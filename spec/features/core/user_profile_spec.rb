# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - User Profile', type: :request, feature: true do
  it 'able to fetch profile' do
    given_logged_in_normal_user
    user_able_fetch_profile
    given_expired_access
    user_unable_fetch_profile
    given_inactive_access
    user_unable_fetch_profile
    given_nil_access
    user_unable_fetch_profile
  end

  it 'able to update profile' do
    given_logged_in_normal_user
    user_able_to_update(first_name, 10)
    user_able_to_update(last_name, 10)
    validation_error_length(first_name, 256)
    validation_error_length(last_name, 256)
  end

  it 'able to add profile image' do
    given_logged_in_normal_user
    able_to_upload_avatar
    validation_error_image_size
    validation_error_image_type
  end

  it 'able to remove profile image' do
    given_logged_in_normal_user
    able_to_delete_avatar
  end

  def given_expired_access
    @access = FactoryBot.create(:access_expired)
  end

  def given_inactive_access
    @access = FactoryBot.create(:access_inactive)
  end

  def given_nil_access
    @access = nil
  end

  def able_to_delete_avatar
    delete '/api/v1/iam/avatar', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    user_able_fetch_profile
    user_have_attached_image(default)
  end

  def able_to_upload_avatar
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'avatars', 'user.png'), 'image/png')
    post '/api/v1/iam/avatar', params: { avatar: file }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    user_able_fetch_profile
    user_have_attached_image(uploaded)
  end

  def validation_error_image_type
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'others', 'user.pdf'), 'application/pdf')
    post '/api/v1/iam/avatar', params: { avatar: file }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def validation_error_image_size
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'big_image.jpeg'), 'image/jpeg')
    post '/api/v1/iam/avatar', params: { avatar: file }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def user_able_to_update(field, length)
    value = Faker::Lorem.characters(number: length)
    put '/api/v1/iam/me', params: { field => value }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    user_able_fetch_profile
    expect(api_user[field.to_sym]).to eq(value)
  end

  def validation_error_length(field, length)
    value = Faker::Lorem.characters(number: length)
    put '/api/v1/iam/me', params: { field => value }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def user_have_attached_image(type)
    expect(api_user[:avatar][:original]).not_to eq(nil)
    expect(api_user[:avatar][:small]).not_to eq(nil)
    expect(api_user[:avatar][:medium]).not_to eq(nil)
    expect(api_user[:avatar][:type]).to eq(type)
  end

  def user_unable_fetch_profile
    p_headers = access.nil? ? {} : { HTTP_ACCESS_TOKEN: access[:access_token] }

    get '/api/v1/iam/me', headers: p_headers
    expect(response.status).to eq(401)
  end
end
