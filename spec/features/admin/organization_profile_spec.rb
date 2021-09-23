# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin - Organization Profile', type: :request, feature: true do
  attr_accessor :organization

  it 'able to fetch organization profile' do
    given_admin_user
    user_able_to_login
    admin_able_fetch_org_profile
  end

  it 'able to update organization profile' do
    given_the_user
    user_able_to_login
    user_able_to_update_org(:name, 15, 401)
    given_admin_user
    user_able_to_login
    user_able_to_update_org(:name, 14, 200)
    user_able_to_update_org(:name, 50, 422)
  end

  it 'able to create organization logo' do
    given_admin_user
    user_able_to_login
    able_to_upload_logo
    validation_error_image_size
    validation_error_image_type
  end

  it 'able to delete organization logo' do
    given_admin_user
    user_able_to_login
    able_to_delete_logo
  end

  def able_to_delete_logo
    delete '/api/v1/admin/organization/logo', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    admin_able_fetch_org_profile
    org_have_attached_image(default)
  end

  def able_to_upload_logo
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'avatars', 'user.png'), 'image/png')
    post '/api/v1/admin/organization/logo',
         params: { logo: file },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    admin_able_fetch_org_profile
    org_have_attached_image(uploaded)
  end

  def validation_error_image_type
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'others', 'user.pdf'), 'application/pdf')
    post '/api/v1/admin/organization/logo',
         params: { logo: file },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def validation_error_image_size
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'big_image.jpg'), 'image/jpg')
    post '/api/v1/admin/organization/logo',
         params: { logo: file },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def org_have_attached_image(type)
    expect(organization[:logo][:original]).not_to eq(nil)
    expect(organization[:logo][:small]).not_to eq(nil)
    expect(organization[:logo][:medium]).not_to eq(nil)
    expect(organization[:logo][:type]).to eq(type)
  end

  def admin_able_fetch_org_profile
    get '/api/v1/admin/organization', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    @organization = JSON.parse(response.body, symbolize_names: true)
  end

  def user_able_to_update_org(field, length, expected_result)
    value = Faker::Lorem.characters(number: length)
    put '/api/v1/admin/organization', params: { field => value }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
    return if expected_result != 200

    admin_able_fetch_org_profile
    expect(organization[field.to_sym]).to eq(value)
  end
end
