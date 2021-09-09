# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  description :string
#  scope       :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Role < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :scope, presence: true, length: { minimum: 2, maximum: 20 }
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }
end
