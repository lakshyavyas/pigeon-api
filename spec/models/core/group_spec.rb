# frozen_string_literal: true

# == Schema Information
#
# Table name: core.groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :string(255)      default("Core::Team")
#  meta_data  :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.groups_on_type  (type)
#

require 'rails_helper'

RSpec.describe Core::Group, type: :model do
  attr_accessor :team, :other_user

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(255) }
  it { is_expected.to have_many(:roles) }
  it { is_expected.to have_many(:inbound_messages) }
  it { is_expected.to have_many(:outbound_messages) }
  it { is_expected.to respond_to(:admins) }
  it { is_expected.to respond_to(:owners) }
  it { is_expected.to respond_to(:members) }

  it 'have proper implementation of admins, owners and members' do
    given_normal_user
    given_a_team_created_by_user
    given_other_user
    given_other_user_added_to_team('admin')
    given_other_user
    given_other_user_added_to_team('member')
    expect(team.admins.count).to eq(1)
    expect(team.owners.count).to eq(1)
    expect(team.members.count).to eq(1)
    expect(team.users.count).to eq(3)
  end

  def given_a_team_created_by_user
    @team = FactoryBot.create(:team)
    user.user_roles.owner.create(roleable: team, logical_name: 'team')
  end

  def given_other_user_added_to_team(user_role = 'member')
    return unless %w[member admin owner].include?(user_role)

    other_user.user_roles.send(user_role).create(roleable: team, logical_name: 'team')
  end
end
