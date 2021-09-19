# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email,
            presence: true,
            length: { minimum: 2, maximum: 100 },
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :user_role, dependent: :destroy
  has_one :simple_auth, dependent: :destroy
  has_many :user_groups
  has_many :accesses
  has_many :groups, through: :user_groups
  has_many :inbound_messages, as: :recipient, class_name: 'Message'
  has_many :outbound_messages, as: :sender, class_name: 'Message'
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
