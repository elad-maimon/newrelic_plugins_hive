require 'newrelic_plugins_hive/version'
require 'newrelic_plugins_hive/configuration'
require 'newrelic_plugins_hive/new_app_generator/new_app_generator'
require 'newrelic_plugins_hive/downloader'
require 'newrelic_plugins_hive/bypass_setup_and_run'

module NewRelicPluginsHive
  
  class << self
    def config
      @configuration ||= Configuration.new
    end

    def generate_new_app(path)
      NewAppGenerator.generate_new_app(path)
    end
    
    def install
      downloader = Downloader.new
      config.plugins.each { |name, options| downloader.install_plugin(name, options) }
    end
    
    def run
      Dir['plugins/*'].each { |file| require file }

      require "newrelic_plugin"

      NewRelic::Plugin::Config.config_file = File.dirname(__FILE__) + "/config/newrelic_plugin.yml"
      NewRelic::Plugin::Run.orig_setup_and_run
    end
  end

end
