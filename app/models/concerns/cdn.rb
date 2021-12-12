# frozen_string_literal: true

# For CDN Helpers functions
module Cdn
  extend ActiveSupport::Concern

  def cdn_blob_urls(obj)
    { original: cdn_uploaded_url(obj.key),
      small: cdn_uploaded_url(obj.variant(size: '50x50').processed.key),
      medium: cdn_uploaded_url(obj.variant(size: '150x150').processed.key),
      type: 'Uploaded' }
  end

  def avatar_cdn_url(variant, key)
    cdn_variant_url variant, key, 'avatars'
  end

  def cdn_uploaded_url(key)
    File.join(cdn_host, 'uploads', key)
  end

  def cdn_variant_url(variant, key, type)
    File.join(cdn_host, type, variant, key)
  end

  def cdn_host
    app_config[:cdn][:url]
  end
end
