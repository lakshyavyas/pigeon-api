# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Team', type: :request, feature: true do
  it 'able to create a team'
  it 'able to delete owned team'
  it 'able to add members to a team when admin of team'
  it 'able to remove members from a team when admin of team'
  it 'able to add members to a team when owner of team'
  it 'able to remove members from a team when owner of team'
  it 'able to list all team'
  it 'able to view one team'
  it 'able to leave a team'
  it 'able to view members in a team'
end
