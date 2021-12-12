# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DryProcess do
  it 'raises exception when called directly' do
    expect { described_class.new({}).perform }.to raise_error(RuntimeError)
  end
end
