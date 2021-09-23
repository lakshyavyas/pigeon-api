# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User - Organization Profile', type: :request, feature: true do
  attr_accessor :organization

  it 'able to fetch organization profile' do
    given_the_user
    user_able_to_login
    user_able_fetch_org_profile
  end

  def user_able_fetch_org_profile
    get '/api/v1/iam/organization', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    @organization = JSON.parse(response.body, symbolize_names: true)
    org_have_attached_image
  end

  def org_have_attached_image
    expect(organization[:logo][:original]).not_to eq(nil)
    expect(organization[:logo][:small]).not_to eq(nil)
    expect(organization[:logo][:medium]).not_to eq(nil)
    expect(organization[:logo][:type]).not_to eq(nil)
  end
end
