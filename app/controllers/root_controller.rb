# frozen_string_literal: true

# Root Controller for '/'
class RootController < ApplicationController
  def index
    render json: {}
  end
end
