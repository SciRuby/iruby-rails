require "iruby/rails/version"

require 'forwardable'

module IRuby
  module Rails
    class << self
      def load(env = nil, sandbox = false, root = nil)
        root ||= Dir.pwd

        # RAILS_ENV needs to be set before config/application is required
        ENV['RAILS_ENV'] ||= env || 'development'

        require File.expand_path('config/boot', root)
        app_path = File.expand_path('config/application', root)
        require_application_and_environment!(app_path)

        setup_console(::Rails.application, sandbox)
      end

      private

      def require_application_and_environment!(app_path)
        require app_path
        ::Rails.application.require_environment!
      end

      def setup_console(app, sandbox)
        app.sandbox = sandbox
        app.load_console

        set_environment! if environment?

        if sandbox
          puts "Loading #{::Rails.env} environment in sandbox (Rails #{::Rails.version})"
          puts "Any modifications you make will be rolled back on exit"
        else
          puts "Loading #{::Rails.env} environment (Rails #{::Rails.version})"
        end

        console = app.config.console || IRB
        if defined?(console::ExtendCommandBundle)
          console::ExtendCommandBundle.include(::Rails::ConsoleMethods)
        end
      end

      def set_environment!
        ::Rails.env = environment
      end

      def environment
        ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"
      end

      alias environment? environment
    end
  end

  def self.load_rails(env = nil, sandbox = false, root = nil)
    Rails.load(env, sandbox, root)
    ::Rails
  end
end
