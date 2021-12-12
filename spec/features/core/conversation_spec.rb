# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Core - Conversation', type: :request, feature: true do
  it 'able to list all conversations'
  it 'able to view one conversation'
  it 'able to resolve a conversation with resolution message'
  it 'able to add another user to conversation, aka assign to another user'
end
