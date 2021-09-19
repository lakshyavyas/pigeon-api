# frozen_string_literal: true

# For every model
module Objectable
  extend ActiveSupport::Concern

  def default_avatar_url(name)
    { original: avatar_cdn_url('full_size', "#{name.first.downcase}.png"),
      small: avatar_cdn_url('small', "#{name.first.downcase}.png"),
      medium: avatar_cdn_url('medium', "#{name.first.downcase}.png"),
      type: 'Default' }
  end
end
