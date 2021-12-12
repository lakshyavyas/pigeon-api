# frozen_string_literal: true

namespace :maintenance do
  desc 'Generate Model I18n file'
  task generate_models_I18n: :environment do
    if Rails.env == 'development' || Rails.env == 'staging'
      Rails.application.eager_load!
      attributes = {}
      models_s = {}
      models = ActiveRecord::Base.descendants.to_a.filter { |s| s.to_s != 'Base' }
      models.map(&:connection)
      ActiveRecord::Base.descendants.to_a.filter { |s| s.to_s != 'Base' }.map do |klass|
        models_s[klass.to_s.underscore.to_s] = klass.to_s.underscore.gsub('_', ' ').humanize.to_s
        klass.attribute_names.each do |attr|
          attributes[klass.to_s.underscore.to_s] = {} unless attributes[klass.to_s.underscore.to_s]
          attributes[klass.to_s.underscore.to_s][attr.to_s.to_s] = attr.to_s.gsub('_', ' ').humanize.to_s
        end
      end
      hash = { 'en-US' => { 'activerecord' => { 'models' => models_s, 'attributes' => attributes } } }
      file = Rails.root.join('config', 'locales', 'en-US', 'active_record_en-US.yml')
      File.open(file, 'w') { |f| f.write(hash.to_yaml.gsub("---\n", '')) }
    end
  end
end
