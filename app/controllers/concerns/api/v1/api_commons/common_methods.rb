# frozen_string_literal: true

module Api
  module V1
    module ApiCommons
      module CommonMethods # :nodoc:
        extend ActiveSupport::Concern

        private

        def check_values
          res = !serializer_klass.nil? && !process_klass.nil? && !process_params.nil?
          render_bad_request standard_error('app.error.bad_request'), Utils::ValidationErrorSerializer unless res
        end

        def set_group
          @group = invoke_method('find_group', params)
          render_bad_request standard_error('app.error.bad_request'), Utils::ErrorSerializer unless group
        end

        def set_klasses
          self.serializer_klass,
            self.process_klass,
            self.process_params = invoke_method('klass_for', params[:action])
        end

        def set_params
          self.serializer_params, self.process_params = invoke_method('params_for', params[:action])
        end

        def module_prefix
          mp = ''
          mp = 't' if request.path.gsub('/api/v1/', '').start_with?('teams')
          mp = 'ch' if request.path.gsub('/api/v1/', '').start_with?('channels')

          mp
        end

        def invoke_method(name, params)
          send("#{module_prefix}_#{name}", params)
        end
      end
    end
  end
end
