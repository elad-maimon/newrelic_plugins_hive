require 'newrelic_plugins_hive/version'
require 'newrelic_plugins_hive/configuration'
require 'newrelic_plugins_hive/downloader'
require 'newrelic_plugins_hive/bypass_setup_and_run'

module NewRelicPluginsHive
  
  class << self
    def config
      @configuration ||= Configuration.new
    end
    
    def install
      downloader = Downloader.new
      
      config.plugins.each do |name, options|
        downloader.install_plugin(name, options)
      end
    end
  end
end
