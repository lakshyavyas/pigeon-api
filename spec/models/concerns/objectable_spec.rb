# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Objectable do
  it 'proper object id implementation' do
    user = FactoryBot.create(:simple_auth_users)
    expect(Core::User.find_by_obj_id(123)).to eq(nil)
    expect(Core::User.find_by_obj_id(user.obj_id).id).to eq(user.id)
    expect(Core::User.exists_by_obj_id(user.obj_id)).to eq(true)
    expect(Core::User.exists_by_obj_id(123)).to eq(false)
    expect(Core::User.where_alt('id', user.obj_id).first.id).to eq(user.id)
    expect(Core::User.where_alt('id', 123).first).to eq(nil)
  end

  it 'proper class name implementation' do
    user = FactoryBot.create(:simple_auth_users)
    expect(user.class_name).to eq('core::user')
  end

  it 'proper result of default image' do
    user = FactoryBot.create(:simple_auth_users)
    images = user.default_image_url(user.first_name)
    expect(images[:original]).not_to eq(nil)
    expect(images[:small]).not_to eq(nil)
    expect(images[:medium]).not_to eq(nil)
    expect(images[:type]).not_to eq(nil)
  end
end
