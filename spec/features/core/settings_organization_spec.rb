# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Organization Settings', type: :request, feature: true do
  attr_accessor :organization

  it 'able to fetch organization profile' do
    given_logged_in_normal_user
    user_able_fetch_org_profile
  end

  it 'admin able to update organization profile' do
    given_logged_in_normal_user
    user_able_to_update_org(:name, 15, 401)
    given_logged_in_admin
    user_able_to_update_org(:name, 14, 200)
    user_able_to_update_org(:name, 500, 422)
  end

  it 'admin able to create organization logo' do
    given_logged_in_admin
    able_to_upload_logo
    validation_error_image_size
    validation_error_image_type
  end

  it 'admin able to delete organization logo' do
    given_logged_in_admin
    able_to_delete_logo
  end

  def user_able_fetch_org_profile
    get '/api/v1/settings/organization', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    @organization = JSON.parse(response.body, symbolize_names: true)
    org_have_attached_image
  end

  def able_to_delete_logo
    delete '/api/v1/settings/organization/logo', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    user_able_fetch_org_profile
    org_have_attached_image(default)
  end

  def able_to_upload_logo
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'avatars', 'user.png'), 'image/png')
    post '/api/v1/settings/organization/logo',
         params: { logo: file },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    user_able_fetch_org_profile
    org_have_attached_image(uploaded)
  end

  def validation_error_image_type
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'others', 'user.pdf'), 'application/pdf')
    post '/api/v1/settings/organization/logo',
         params: { logo: file },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def validation_error_image_size
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'big_image.jpeg'), 'image/jpeg')
    post '/api/v1/settings/organization/logo',
         params: { logo: file },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def org_have_attached_image(type = 'any')
    expect(organization[:logo][:original]).not_to eq(nil)
    expect(organization[:logo][:small]).not_to eq(nil)
    expect(organization[:logo][:medium]).not_to eq(nil)
    expect(organization[:logo][:type]).to eq(type) unless type == 'any'
  end

  def user_able_to_update_org(field, length, expected_result)
    value = Faker::Lorem.characters(number: length)
    put '/api/v1/settings/organization',
        params: { field => value },
        headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
    return if expected_result != 200

    user_able_fetch_org_profile
    expect(organization[field.to_sym]).to eq(value)
  end
end
