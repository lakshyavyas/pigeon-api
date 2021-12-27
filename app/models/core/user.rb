# frozen_string_literal: true

# == Schema Information
#
# Table name: core.users
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Core
  class User < ApplicationRecord
    validates :first_name, presence: true, length: { minimum: 2, maximum: 255 }
    validates :last_name, presence: true, length: { minimum: 2, maximum: 255 }
    validates :email,
              presence: true,
              length: { minimum: 2, maximum: 255 },
              uniqueness: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }

    has_one :simple_auth, dependent: :destroy
    has_many :roles, as: :roleable, class_name: 'Core::Role'
    has_many :accesses
    has_many :inbound_messages, as: :recipient, class_name: 'Core::Message'
    has_many :outbound_messages, as: :sender, class_name: 'Core::Message'
    has_one_attached :avatar
    validates :avatar, presence: false, size: { less_than: 512.kilobytes }, content_type: app_config.allowed_images

    def avatar_urls
      if avatar&.attached?
        cdn_blob_urls(avatar)
      else
        default_image_url(first_name)
      end
    end
  end
end
