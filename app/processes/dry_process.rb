# frozen_string_literal: true

# Base class for Dry Process
class DryProcess
  attr_accessor :args, :error, :output, :unauthorized

  def initialize(args)
    self.args = args
    self.output = true
    self.unauthorized = false
  end

  def perform
    init
    work if validation

    error.nil? ? output : false
  end

  def error_method
    if unauthorized
      'render_unauthorized'
    else
      'render_unprocessable_entity'
    end
  end

  def error_serializer
    if unauthorized
      Api::V1::Utils::ErrorSerializer
    else
      Api::V1::Utils::ValidationErrorSerializer
    end
  end

  private

  class TValidationErrorMessages # :nodoc:
    attr_accessor :full_messages

    def initialize(full_messages)
      self.full_messages = full_messages
    end
  end

  class TValidationError # :nodoc:
    attr_accessor :errors, :message

    def initialize(errors)
      self.message = errors.full_messages.join(',')
      self.errors = errors
    end

    def backtrace
      __LINE__
    end
  end

  def gen_validation_error(message)
    TValidationError.new(TValidationErrorMessages.new([message]))
  end

  def validation_error(message)
    self.error = gen_validation_error(message)
  end

  def not_allowed_to_access(name, id)
    self.unauthorized = true
    name = I18n.t("app.arbitrary.#{name}")
    error_message = I18n.t('app.error.no_role_for_object', { object_name: name, id: id })
    self.error = gen_validation_error(error_message)
  end

  def resource_to_add_not_exists(name, resource_name, id)
    self.unauthorized = false
    name = I18n.t("app.arbitrary.#{name}")
    resource_name = I18n.t("app.arbitrary.#{resource_name}")
    error_message = I18n.t('app.error.resource_to_add_not_exists',
                           { object_name: name, resource_name: resource_name, id: id })
    self.error = gen_validation_error(error_message)
  end

  def init
    true
  end

  def work
    raise I18n.t('app.error.not_implemented')
  end

  def validation
    true
  end
end
