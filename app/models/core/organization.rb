# frozen_string_literal: true

# == Schema Information
#
# Table name: core.organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Core
  class Organization < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 40 }
    has_one_attached :logo
    validates :logo, presence: false, size: { less_than: 512.kilobytes }, content_type: app_config.allowed_images

    def logo_urls
      if logo&.attached?
        cdn_blob_urls(logo)
      else
        default_avatar_url(name)
      end
    end
  end
end
