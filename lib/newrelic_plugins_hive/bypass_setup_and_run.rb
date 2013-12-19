require 'newrelic_plugin'

module NewRelicPluginsHive

  ::NewRelic::Plugin::Run.class_eval do
    class << self
      unless method_defined?(:bypass_setup_and_run)
        define_method(:bypass_setup_and_run) do
          puts "Bypassing setup_and_run"
        end

        alias_method :orig_setup_and_run, :setup_and_run
        alias_method :setup_and_run, :bypass_setup_and_run
      end
    end
  end

end
