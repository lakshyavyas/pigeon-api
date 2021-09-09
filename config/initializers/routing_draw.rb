# frozen_string_literal: true

require_relative '../../lib/patch/draw_route'
ActionDispatch::Routing::Mapper.prepend ::Patch::DrawRoute
