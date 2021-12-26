# frozen_string_literal: true

Pry.config.prompt_name = "[pigeon-api][#{Rails.env}]" if Pry.config&.prompt_name

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
