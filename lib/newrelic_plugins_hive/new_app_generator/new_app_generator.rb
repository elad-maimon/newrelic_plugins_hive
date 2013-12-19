require 'newrelic_plugin'

module NewRelicPluginsHive

  class NewAppGenerator
    def self.generate_new_app(path)
      Dir.mkdir path

      copy_template 'config/newrelic_hive.yml', path
      copy_template 'config/newrelic_plugin.yml', path
      copy_template 'Gemfile', path
      copy_template 'README.md', path
    end
    
    private
    
    def self.copy_template(file, path)
      src = File.expand_path("../templates/#{file}", __FILE__)
      dst = File.join Dir.pwd, path, file

      FileUtils.mkdir_p(File.dirname dst)
      FileUtils.cp src, dst
    end
  end

end
