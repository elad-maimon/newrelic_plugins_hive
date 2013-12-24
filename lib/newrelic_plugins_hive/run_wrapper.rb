require 'newrelic_plugin'

module NewRelicPluginsHive

  class RunWrapper
    def self.bypass_run
      ::NewRelic::Plugin::Run.class_eval do
        class << self
          unless method_defined?(:bypass_setup_and_run)
            define_method(:bypass_setup_and_run) do
              "Bypassing setup_and_run"
            end

            alias_method :orig_setup_and_run, :setup_and_run
            alias_method :setup_and_run, :bypass_setup_and_run
          end
        end
      end
    end
    
    def self.call_original_run
      NewRelic::Plugin::Run.orig_setup_and_run
    end
  end

end
