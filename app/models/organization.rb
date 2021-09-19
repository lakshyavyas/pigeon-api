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
  has_one_attached :logo
  validates :logo, presence: false, size: { less_than: 512.kilobytes }, content_type: app_config.allowed_images
end
