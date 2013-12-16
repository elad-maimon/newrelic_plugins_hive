module NewRelicPluginsHive

  class Configuration
    include Singleton
    
    attr_accessor :plugins
    
    def initialize
      config_file = File.expand_path('config/newrelic_hive.yml')
      raise "Can't find configuration file: #{config_file}" unless File.exists? config_file
      
      configuration = YAML.load_file(config_file)
    end
  end

end
