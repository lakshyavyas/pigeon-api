# frozen_string_literal: true

# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  require 'annotate'
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    hash = YAML.safe_load(File.read(Rails.root.join('annotate.yml')))
    Annotate.set_defaults(hash)
  end

  Annotate.load_tasks
end
