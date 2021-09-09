# frozen_string_literal: true

# ApplicationRecord abstract class for all models
class ApplicationRecord < ActiveRecord::Base
  include Objectable
  self.abstract_class = true
end
