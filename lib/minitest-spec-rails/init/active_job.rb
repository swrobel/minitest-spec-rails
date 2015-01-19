module MiniTestSpecRails
  module Init
    module ActiveJobBehavior

      extend ActiveSupport::Concern

      included do
        register_spec_type(self) { |desc| Class === desc && desc < ActiveJob::Base }
        register_spec_type(/Job( ?Test)?\z/, self)
        register_spec_type(self) { |desc| Class === desc && desc < self }
        extend Descriptions
      end

      module Descriptions

        def described_class
          determine_default_mailer(name)
        end

      end

    end
  end
end

ActiveJob::TestCase.send :include, MiniTestSpecRails::Init::ActiveJobBehavior

