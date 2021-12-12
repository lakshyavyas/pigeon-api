# frozen_string_literal: true

module Api
  module V1
    # Base Controller to be used by all api v1 controllers
    class BaseController < ApplicationController
      include Api::V1
      include Responses
      include Accesses
      include Errors

      attr_accessor :user, :access, :organization
    end
  end
end
