# frozen_string_literal: true
# == Schema Information
#
# Table name: core.users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Core
  class User < ApplicationRecord
    validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
    validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
    validates :email,
              presence: true,
              length: { minimum: 2, maximum: 100 },
              uniqueness: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }

    has_one :simple_auth, dependent: :destroy
    has_many :user_roles, dependent: :destroy
    has_many :user_groups
    has_many :accesses
    has_many :groups, through: :user_groups
    has_many :inbound_messages, as: :recipient, class_name: 'Core::Message'
    has_many :outbound_messages, as: :sender, class_name: 'Core::Message'
    has_one_attached :avatar
    validates :avatar, presence: false, size: { less_than: 512.kilobytes }, content_type: app_config.allowed_images

    def avatar_urls
      if avatar&.attached?
        cdn_blob_urls(avatar)
      else
        default_avatar_url(first_name)
      end
    end
  end
end
