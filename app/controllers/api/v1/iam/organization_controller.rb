# frozen_string_literal: true

module Api
  module V1
    module Iam
      # Organization controller
      class OrganizationController < BaseController
        before_action :authenticate

        def index
          render_ok organization, Iam::OrganizationSerializer
        end
      end
    end
  end
end
