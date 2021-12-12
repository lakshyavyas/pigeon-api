# frozen_string_literal: true

# Base class for Dry Process
class DryProcess
  attr_accessor :args, :error

  def initialize(args)
    self.args = args
  end

  def perform
    init
    work if validation

    error.nil?
  end

  private

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
