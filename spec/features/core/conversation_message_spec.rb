# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Conversation Message', type: :request, feature: true do
  it 'able to list all message in a conversation'
  it 'able to get one message in a conversation'
  it 'able to post message to conversation'
  it 'able to delete message from conversation'
  it 'able to edit message in conversation'
  it 'able to upload approved files to conversation'
  it 'able to delete uploaded files from conversation'
end
