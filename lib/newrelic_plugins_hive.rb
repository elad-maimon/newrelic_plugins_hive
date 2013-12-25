require 'newrelic_plugins_hive/version'
require 'newrelic_plugins_hive/configuration'
require 'newrelic_plugins_hive/new_app_generator/new_app_generator'
require 'newrelic_plugins_hive/downloader'
require 'newrelic_plugins_hive/run_wrapper'

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
      RunWrapper.bypass_run
      Dir['plugins/*'].each { |file| require "#{Dir.pwd}/#{file}" }

      NewRelic::Plugin::Config.config_file = Dir.pwd + "/config/newrelic_plugin.yml"
      RunWrapper.call_original_run
    end
  end

end
