# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User - Channel', type: :request, feature: true do
  it 'able to list all channel'
  it 'able to view one channel'
  it 'able to leave a channel'
  it 'able to join a public channel'
  it 'able to join a private channel only when invited'
end
