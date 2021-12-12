# frozen_string_literal: true

# We're patching `ActionDispatch::Routing::Mapper` in
# config/initializers/routing_draw.rb
module Patch
  # DrawRoute to separate each route for cleaner look
  module DrawRoute
    RoutesNotFound = Class.new(StandardError)

    def draw(routes_name, version = 'v1')
      drawn_any = draw_route(route_path("config/routes/#{version}/#{routes_name}.rb"))

      drawn_any || raise(RoutesNotFound, "Cannot find #{routes_name}")
    end

    def route_path(routes_name)
      Rails.root.join(routes_name)
    end

    def draw_route(path)
      if File.exist?(path)
        instance_eval(File.read(path))
        true
      else
        false
      end
    end
  end
end
