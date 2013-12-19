module NewRelicPluginsHive

  class Downloader
    def initialize
      validate_wget_exists
      FileUtils.mkdir_p 'temp'
      FileUtils.mkdir_p 'plugins'
    end
    
    def install_plugin(name, options)
      puts "Installing plugin #{name}..."
      
      validate_plugin_source(options)
      download_and_extract(name, options)
    end
    
    private
    
    def validate_wget_exists
      raise "Wget must be installed on your machine. For more help: http://www.gnu.org/software/wget/" unless `wget -V` =~ /^GNU Wget/
    end

    def validate_plugin_source(options)
      raise "\tMust specify github source for plugin #{name}" unless options[:github] =~ /^https:\/\/github.com/
    end

    def download_and_extract(name, options)
      `wget -O temp/#{name}.zip #{options[:github]}/archive/master.zip`

      files_in_zip = `zipinfo -1 temp/#{name}.zip`.split("\n")
      full_agent_path = files_in_zip.find_all {|s| s =~ /#{options[:agent_path]}$/}
      
      raise "\tAgent path must exists and be unique in plugin" unless full_agent_path.size == 1

      `unzip -p temp/#{name}.zip "#{full_agent_path.first}" > plugins/#{name}.rb`
    end
  end
  
end
