# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin - Manage Users', type: :request, feature: true do
  it 'able to list all users'
  it 'able to create new user'
  it 'able to update user'
  it 'able to suspend user'
  it 'able to unsuspend a suspended user'
  it "able to change user's password"
  it 'able to delete user'
end
