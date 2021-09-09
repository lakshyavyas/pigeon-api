# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  has_one_attached :logo do |attachable|
    attachable.variant :small, resize: '50x50'
    attachable.variant :medium, resize: '150x150'
  end
  validates :logo, presence: false, size: { less_than: 5.megabytes }, content_type: app_config.allowed_images
end
