# frozen_string_literal: true

# For every model
module Objectable
  extend ActiveSupport::Concern
  included do
    class << self
      def find_by_obj_id(value)
        find_by(id: unmask_value(value))
      end

      def exists_by_obj_id(value)
        exists?(id: unmask_value(value))
      end

      def where_alt(field, value)
        where(field => unmask_value(value))
      end
    end
  end

  def class_name
    self.class.to_s.downcase
  end

  def obj_id
    mask_value(id)
  end

  def default_image_url(name)
    { original: avatar_cdn_url('full_size', "#{name.first.downcase}.png"),
      small: avatar_cdn_url('small', "#{name.first.downcase}.png"),
      medium: avatar_cdn_url('medium', "#{name.first.downcase}.png"),
      type: 'Default' }
  end
end
