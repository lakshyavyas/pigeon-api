# frozen_string_literal: true

# == Schema Information
#
# Table name: core.organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Core
  class Organization < ApplicationRecord
    has_one_attached :logo
    has_many :roles, as: :roleable, class_name: 'Core::Role'
    validates :name, presence: true, length: { minimum: 3, maximum: 255 }
    validates :logo, presence: false, size: { less_than: 512.kilobytes }, content_type: app_config.allowed_images

    def logo_urls
      if logo&.attached?
        cdn_blob_urls(logo)
      else
        default_image_url(name)
      end
    end
  end
end
