# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Team', type: :request, feature: true do
  attr_accessor :team, :other_user

  include Api::V1::RoleFactory

  it 'able to create a team' do
    given_logged_in_normal_user
    validation_error_team_name
    user_able_to_create_a_team
  end

  it 'able to list all team' do
    given_other_user
    given_logged_in_normal_user
    user_able_to_create_a_team
    given_a_team_created_by_other_user('member')
    user_able_to_list_teams
  end

  it 'able to view one team' do
    given_other_user
    given_logged_in_normal_user
    user_able_to_create_a_team
    user_able_to_get_team('owner')
    given_a_team_created_by_other_user('member')
    user_able_to_get_team('member')
    given_a_team_created_by_other_user('admin')
    user_able_to_get_team('admin')
    given_a_team_created_by_other_user('no_role')
    user_not_able_to_get_team
  end

  it 'able to delete owned team' do
    given_other_user
    given_logged_in_normal_user
    given_a_team_created_by_user
    user_able_to_delete_the_team
    given_a_team_created_by_other_user
    user_able_to_delete_the_team(401)
  end

  it 'admin able to delete any team' do
    given_other_user
    given_logged_in_admin
    given_a_team_created_by_other_user('member')
    user_able_to_delete_the_team(200)
  end

  it 'able to update owned team' do
    given_other_user
    given_logged_in_normal_user
    given_a_team_created_by_user
    user_able_to_update_the_team(256, 422)
    user_able_to_update_the_team(10, 200)
    given_a_team_created_by_other_user
    user_able_to_update_the_team(10, 401)
  end

  it 'admin able to update any team' do
    given_other_user
    given_logged_in_admin
    given_a_team_created_by_other_user('member')
    user_able_to_update_the_team(10, 200)
  end

  it 'able to add members to owned team' do
    given_logged_in_normal_user
    given_a_team_created_by_user
    given_other_user
    able_to_add_member_to_team('admin', 201)
    given_other_user
    able_to_add_member_to_team('member', 201)
    given_other_user
    able_to_add_member_to_team('owner', 201)
    able_to_add_member_to_team('admin', 422)
    given_other_user
    able_to_add_member_to_team('god', 422)
    given_fake_other_user
    able_to_add_member_to_team('admin', 422)
  end

  it 'able to add members to a team when admin of team' do
    given_logged_in_normal_user
    given_other_user
    given_a_team_created_by_other_user('admin')
    given_other_user
    able_to_add_member_to_team('member', 201)
    given_other_user
    able_to_add_member_to_team('admin', 201)
    given_other_user
    able_to_add_member_to_team('owner', 201)
  end

  it 'able to view members in a team when admin of team' do
    given_logged_in_normal_user
    given_a_team_created_by_user
    given_other_user
    able_to_add_member_to_team('admin', 201)
    given_other_user
    able_to_add_member_to_team('member', 201)
    given_other_user
    able_to_add_member_to_team('owner', 201)
    able_to_list_team_members(4)
  end

  it 'able to view members in a team when member of team' do
    given_logged_in_normal_user
    given_other_user
    given_a_team_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_team('admin')
    able_to_list_team_members(3)
  end

  it 'able to remove members from a team' do
    given_logged_in_normal_user

    # not allowed to remove
    given_other_user
    given_a_team_created_by_other_user('member')
    able_to_remove_team_member(other_user, 401)

    # removing only owner, result in validation error
    given_a_team_created_by_other_user('admin')
    able_to_remove_team_member(other_user, 422)

    # removing on existing user
    given_a_team_created_by_other_user('admin')
    given_fake_other_user
    able_to_remove_team_member(other_user, 422)

    # remove user not in team
    given_a_team_created_by_user
    given_other_user
    able_to_remove_team_member(other_user, 422)

    # remove successfully
    given_a_team_created_by_user
    given_other_user
    given_other_user_added_to_team('member')
    able_to_remove_team_member(other_user, 200)
  end

  it 'able to remove members from a team when admin of team' do
    given_logged_in_normal_user
    given_other_user
    given_a_team_created_by_other_user('admin')
    given_other_user
    given_other_user_added_to_team('member')
    able_to_remove_team_member(user, 200)
  end

  it 'able to leave a team' do
    given_logged_in_normal_user
    given_other_user
    given_a_team_created_by_other_user('member')
    able_to_remove_team_member(user, 200)
  end

  it 'able to update team member' do
    given_logged_in_normal_user

    # not authorized to update team member
    given_other_user
    given_a_team_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_team('member')
    able_to_update_team_member(other_user, 'admin', 401)

    # applying same role
    given_logged_in_admin
    given_other_user
    given_a_team_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_team('member')
    able_to_update_team_member(other_user, 'member', 422)

    # authorized as admin user, but fake user
    given_logged_in_admin
    given_other_user
    given_a_team_created_by_other_user('member')
    given_fake_other_user
    able_to_update_team_member(other_user, 'admin', 422)

    # authorized as admin user, but target user not in team
    given_logged_in_admin
    given_a_team_created_by_user
    given_other_user
    able_to_update_team_member(other_user, 'member', 422)

    # authorized as admin user, but invalid role name
    given_logged_in_admin
    given_other_user
    given_a_team_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_team('member')
    able_to_update_team_member(other_user, 'not_a_role', 422)

    # authorized as admin user, but trying remove self
    given_logged_in_admin
    given_a_team_created_by_user
    able_to_update_team_member(user, 'member', 422)

    # authorized as admin user
    given_logged_in_admin
    given_other_user
    given_a_team_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_team('member')
    able_to_update_team_member(other_user, 'admin', 200)
  end

  it 'able to update team member when admin of team' do
    given_logged_in_normal_user
    given_other_user
    given_a_team_created_by_other_user('admin')
    given_other_user
    given_other_user_added_to_team('member')
    able_to_update_team_member(other_user, 'admin', 200)
  end

  def able_to_update_team_member(target_user, target_role, expected_result)
    put "/api/v1/teams/#{team.obj_id}/members/#{target_user.obj_id}",
        params: { role: target_role },
        headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
  end

  def able_to_remove_team_member(target_user, expected_result)
    delete "/api/v1/teams/#{team.obj_id}/members/#{target_user.obj_id}",
           params: {},
           headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
  end

  def able_to_add_member_to_team(role_to_add, expected_result)
    post "/api/v1/teams/#{team.obj_id}/members",
         params: { user_id: other_user.obj_id, role: role_to_add },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }

    expect(response.status).to eq(expected_result)
    return unless expected_result == 201

    user = JSON.parse(response.body, symbolize_names: true)
    expect(user[:role].start_with?(role_to_add)).to eq(true)
  end

  def able_to_list_team_members(count)
    get "/api/v1/teams/#{team.obj_id}/members", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    users = JSON.parse(response.body, symbolize_names: true)
    expect(users.length).to eq(count)
  end

  def user_able_to_list_teams
    get '/api/v1/teams', headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    teams = JSON.parse(response.body, symbolize_names: true)
    expect(teams.length).to eq(2)
  end

  def user_able_to_create_a_team
    team_params = { name: Faker::Lorem.characters(number: 10) }
    post '/api/v1/teams', params: team_params, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(201)
    @team = JSON.parse(response.body, symbolize_names: true)
    expect(team[:role].start_with?('owner')).to eq(true)
  end

  def validation_error_team_name
    team_params = { name: Faker::Lorem.characters(number: 256) }
    post '/api/v1/teams', params: team_params, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def user_able_to_get_team(expected_role)
    obj_id = team[:obj_id] || team.obj_id
    get "/api/v1/teams/#{obj_id}", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    @team = JSON.parse(response.body, symbolize_names: true)
    expect(team[:role].start_with?(expected_role)).to eq(true)
  end

  def user_not_able_to_get_team
    obj_id = team[:obj_id] || team.obj_id
    get "/api/v1/teams/#{obj_id}", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(401)
  end

  def given_a_team_created_by_user
    @team = FactoryBot.create(:team)
    team.meta_data = { owner: user.id }
    team.save
    user.user_roles.owner.create(roleable: team, logical_name: 'team')
  end

  def given_a_team_created_by_other_user(user_role = 'member')
    @team = FactoryBot.create(:team)
    team.meta_data = { owner: other_user.id }
    team.save
    other_user.user_roles.owner.create(roleable: team, logical_name: 'team')
    return unless %w[member admin owner].include?(user_role)

    user.user_roles.send(user_role).create(roleable: team, logical_name: 'team')
  end

  def user_able_to_update_the_team(name_len, expected_result = 200)
    name = Faker::Lorem.characters(number: name_len)
    put "/api/v1/teams/#{team.obj_id}", params: { name: name }, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
    return unless expected_result == 200

    team.reload
    expect(team.name).to eq(name)
  end

  def user_able_to_delete_the_team(expected_result = 200)
    delete "/api/v1/teams/#{team.obj_id}", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
  end

  def given_other_user_added_to_team(user_role = 'member')
    return unless %w[member admin owner].include?(user_role)

    other_user.user_roles.send(user_role).create(roleable: team, logical_name: 'team')
  end
end
