module NewRelicPluginsHive

  class Configuration
    attr_accessor :plugins
    
    def initialize
      config_file = File.expand_path('config/newrelic_hive.yml')
      raise "Can't find configuration file: #{config_file}" unless File.exists? config_file
      
      configuration = symbolize_keys(YAML.load_file(config_file))
      
      @plugins = configuration[:plugins]
    end
    
    private

    def symbolize_keys(hash)
      hash.inject({}) do |res, (key, val)|
        key = key.to_sym
        val = symbolize_keys(val) if val.is_a? Hash

        res[key] = val
        res
      end
    end
  end
  
end
