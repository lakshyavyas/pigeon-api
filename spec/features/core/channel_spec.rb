# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Channel', type: :request, feature: true do
  attr_accessor :channel, :other_user

  include Api::V1::RoleFactory

  it 'able to create a channel' do
    given_logged_in_normal_user
    validation_error_channel_name
    user_able_to_create_a_channel
  end

  it 'able to list all joined channel' do
    given_other_user
    given_logged_in_normal_user
    user_able_to_create_a_channel
    given_a_channel_created_by_other_user('member')
    user_able_to_list_channels
  end

  it 'able to list all public channels' do
    given_logged_in_normal_user
    given_other_user
    given_a_channel_created_by_other_user('member', is_public: true)
    given_a_channel_created_by_other_user('no_role', is_public: true)
    given_a_channel_created_by_other_user('no_role', is_public: true)
    given_a_channel_created_by_other_user('no_role', is_public: true)
    user_able_to_list_channels(public: true, expected_count: 4)
  end

  it 'able to search all public channels' do
    given_logged_in_normal_user
    given_other_user
    given_public_channels_created_by_other_user
    user_able_to_list_channels(public: true, search: 'thing', expected_count: 2)
  end

  it 'able to view one channel' do
    given_other_user
    given_logged_in_normal_user
    user_able_to_create_a_channel
    user_able_to_get_channel('owner')
    given_a_channel_created_by_other_user('member')
    user_able_to_get_channel('member')
    given_a_channel_created_by_other_user('admin')
    user_able_to_get_channel('admin')
    given_a_channel_created_by_other_user('no_role')
    user_not_able_to_get_channel
  end

  it 'able to delete owned channel' do
    given_other_user
    given_logged_in_normal_user
    given_a_channel_created_by_user
    user_able_to_delete_the_channel
    given_a_channel_created_by_other_user
    user_able_to_delete_the_channel(401)
  end

  it 'admin able to delete any channel' do
    given_other_user
    given_logged_in_admin
    given_a_channel_created_by_other_user('member')
    user_able_to_delete_the_channel(200)
  end

  it 'able to update owned channel' do
    given_other_user
    given_logged_in_normal_user
    given_a_channel_created_by_user
    user_able_to_update_the_channel(256, 422)
    user_able_to_update_the_channel(10, 200)
    given_a_channel_created_by_other_user
    user_able_to_update_the_channel(10, 401)
  end

  it 'admin able to update any channel' do
    given_other_user
    given_logged_in_admin
    given_a_channel_created_by_other_user('member')
    user_able_to_update_the_channel(10, 200)
  end

  it 'able to add members to owned channel' do
    given_logged_in_normal_user
    given_a_channel_created_by_user
    given_other_user
    able_to_add_member_to_channel('admin', 201, other_user)
    given_other_user
    able_to_add_member_to_channel('member', 201, other_user)
    given_other_user
    able_to_add_member_to_channel('owner', 201, other_user)
    able_to_add_member_to_channel('admin', 422, other_user)
    given_other_user
    able_to_add_member_to_channel('god', 422, other_user)
    given_fake_other_user
    able_to_add_member_to_channel('admin', 422, other_user)
  end

  it 'able to add members to a channel when admin of channel' do
    given_logged_in_normal_user
    given_other_user
    given_a_channel_created_by_other_user('admin')
    given_other_user
    able_to_add_member_to_channel('member', 201, other_user)
    given_other_user
    able_to_add_member_to_channel('admin', 201, other_user)
    given_other_user
    able_to_add_member_to_channel('owner', 201, other_user)
  end

  it 'able to view members in a channel when admin of channel' do
    given_logged_in_normal_user
    given_a_channel_created_by_user
    given_other_user
    able_to_add_member_to_channel('admin', 201, other_user)
    given_other_user
    able_to_add_member_to_channel('member', 201, other_user)
    given_other_user
    able_to_add_member_to_channel('owner', 201, other_user)
    able_to_list_channel_members(4)
  end

  it 'able to view members in a channel when member of channel' do
    given_logged_in_normal_user
    given_other_user
    given_a_channel_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_channel('admin')
    able_to_list_channel_members(3)
  end

  it 'able to remove members from a channel' do
    given_logged_in_normal_user

    # not allowed to remove
    given_other_user
    given_a_channel_created_by_other_user('member')
    able_to_remove_channel_member(other_user, 401)

    # removing only owner, result in validation error
    given_a_channel_created_by_other_user('admin')
    able_to_remove_channel_member(other_user, 422)

    # removing on existing user
    given_a_channel_created_by_other_user('admin')
    given_fake_other_user
    able_to_remove_channel_member(other_user, 422)

    # remove user not in channel
    given_a_channel_created_by_user
    given_other_user
    able_to_remove_channel_member(other_user, 422)

    # remove successfully
    given_a_channel_created_by_user
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_remove_channel_member(other_user, 200)
  end

  it 'able to remove members from a channel when admin of channel' do
    given_logged_in_normal_user
    given_other_user
    given_a_channel_created_by_other_user('admin')
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_remove_channel_member(user, 200)
  end

  it 'able to leave a channel' do
    given_logged_in_normal_user
    given_other_user
    given_a_channel_created_by_other_user('member')
    able_to_remove_channel_member(user, 200)
  end

  it 'able to update channel member' do
    given_logged_in_normal_user

    # not authorized to update channel member
    given_other_user
    given_a_channel_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_update_channel_member(other_user, 'admin', 401)

    # applying same role
    given_logged_in_admin
    given_other_user
    given_a_channel_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_update_channel_member(other_user, 'member', 422)

    # authorized as admin user, but fake user
    given_logged_in_admin
    given_other_user
    given_a_channel_created_by_other_user('member')
    given_fake_other_user
    able_to_update_channel_member(other_user, 'admin', 422)

    # authorized as admin user, but target user not in channel
    given_logged_in_admin
    given_a_channel_created_by_user
    given_other_user
    able_to_update_channel_member(other_user, 'member', 422)

    # authorized as admin user, but invalid role name
    given_logged_in_admin
    given_other_user
    given_a_channel_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_update_channel_member(other_user, 'not_a_role', 422)

    # authorized as admin user, but trying remove self
    given_logged_in_admin
    given_a_channel_created_by_user
    able_to_update_channel_member(user, 'member', 422)

    # authorized as admin user
    given_logged_in_admin
    given_other_user
    given_a_channel_created_by_other_user('member')
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_update_channel_member(other_user, 'admin', 200)
  end

  it 'able to update channel member when admin of channel' do
    given_logged_in_normal_user
    given_other_user
    given_a_channel_created_by_other_user('admin')
    given_other_user
    given_other_user_added_to_channel('member')
    able_to_update_channel_member(other_user, 'admin', 200)
  end

  it 'able to join any public channel' do
    given_logged_in_normal_user
    given_other_user

    # not able to join private channel
    given_a_channel_created_by_other_user('no_role', is_public: false)
    able_to_add_member_to_channel('owner', 401, user)
    able_to_add_member_to_channel('admin', 401, user)
    able_to_add_member_to_channel('member', 401, user)

    # able to join public channel
    given_a_channel_created_by_other_user('no_role', is_public: true)
    able_to_add_member_to_channel('owner', 422, user)
    able_to_add_member_to_channel('admin', 422, user)
    able_to_add_member_to_channel('member', 201, user)
  end

  def able_to_update_channel_member(target_user, target_role, expected_result)
    put "/api/v1/channels/#{channel.obj_id}/members/#{target_user.obj_id}",
        params: { role: target_role },
        headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
  end

  def able_to_remove_channel_member(target_user, expected_result)
    delete "/api/v1/channels/#{channel.obj_id}/members/#{target_user.obj_id}",
           params: {},
           headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
  end

  def able_to_add_member_to_channel(role_to_add, expected_result, member_to_add)
    post "/api/v1/channels/#{channel.obj_id}/members",
         params: { user_id: member_to_add.obj_id, role: role_to_add },
         headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
    return unless expected_result == 201

    user = JSON.parse(response.body, symbolize_names: true)
    expect(user[:role].start_with?(role_to_add)).to eq(true)
  end

  def able_to_list_channel_members(count)
    get "/api/v1/channels/#{channel.obj_id}/members", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    users = JSON.parse(response.body, symbolize_names: true)
    expect(users.length).to eq(count)
  end

  def user_able_to_list_channels(public: false, search: nil, expected_count: 2)
    l_path = '/api/v1/channels'
    l_path = '/api/v1/channels/public' if public && search.nil?
    l_path = "/api/v1/channels/public?q=#{search}" if public && !search.nil?

    get l_path, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    channels = JSON.parse(response.body, symbolize_names: true)
    expect(channels.length).to eq(expected_count)
  end

  def user_able_to_create_a_channel
    channel_params = { name: Faker::Lorem.characters(number: 10) }
    post '/api/v1/channels', params: channel_params, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(201)
    @channel = JSON.parse(response.body, symbolize_names: true)
    expect(channel[:role].start_with?('owner')).to eq(true)
  end

  def validation_error_channel_name
    channel_params = { name: Faker::Lorem.characters(number: 256) }
    post '/api/v1/channels', params: channel_params, headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(422)
  end

  def user_able_to_get_channel(expected_role)
    obj_id = channel[:obj_id] || channel.obj_id
    get "/api/v1/channels/#{obj_id}", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(200)
    @channel = JSON.parse(response.body, symbolize_names: true)
    expect(channel[:role].start_with?(expected_role)).to eq(true)
  end

  def user_not_able_to_get_channel
    obj_id = channel[:obj_id] || channel.obj_id
    get "/api/v1/channels/#{obj_id}", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(401)
  end

  def given_a_channel_created_by_user(is_public: false)
    @channel = FactoryBot.create(:channel)
    channel.meta_data = { owner: user.id, is_public: is_public }
    channel.save
    user.roles.owner.create(resource: channel, logical_name: 'channel')
  end

  def given_public_channels_created_by_other_user
    @channel = Core::Channel.create(name: 'fun_things', meta_data: { owner: other_user.id, is_public: true })
    other_user.roles.owner.create(resource: channel, logical_name: 'channel')
    @channel = Core::Channel.create(name: 'sun_things', meta_data: { owner: other_user.id, is_public: true })
    other_user.roles.owner.create(resource: channel, logical_name: 'channel')
    @channel = Core::Channel.create(name: 'fun_stuffs', meta_data: { owner: other_user.id, is_public: true })
    other_user.roles.owner.create(resource: channel, logical_name: 'channel')
  end

  def given_a_channel_created_by_other_user(user_role = 'member', is_public: false)
    @channel = FactoryBot.create(:channel)
    channel.meta_data = { owner: other_user.id, is_public: is_public }
    channel.save
    other_user.roles.owner.create(resource: channel, logical_name: 'channel')
    return unless %w[member admin owner].include?(user_role)

    user.roles.send(user_role).create(resource: channel, logical_name: 'channel')
  end

  def user_able_to_update_the_channel(name_len, expected_result = 200)
    name = Faker::Lorem.characters(number: name_len)
    put "/api/v1/channels/#{channel.obj_id}",
        params: { name: name },
        headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
    return unless expected_result == 200

    channel.reload
    expect(channel.name).to eq(name)
  end

  def user_able_to_delete_the_channel(expected_result = 200)
    delete "/api/v1/channels/#{channel.obj_id}", headers: { HTTP_ACCESS_TOKEN: access[:access_token] }
    expect(response.status).to eq(expected_result)
  end

  def given_other_user_added_to_channel(user_role = 'member')
    return unless %w[member admin owner].include?(user_role)

    other_user.roles.send(user_role).create(resource: channel, logical_name: 'channel')
  end
end
