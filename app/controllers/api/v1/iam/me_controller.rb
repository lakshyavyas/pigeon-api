# frozen_string_literal: true

module Api
  module V1
    module Iam
      # User profile controller
      class MeController < BaseController
        before_action :authenticate

        def index
          render_ok user, Iam::MeSerializer
        end
      end
    end
  end
end
