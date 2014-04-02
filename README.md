# NewRelic Plugins Hive [![Build Status](https://api.travis-ci.org/elad-maimon/newrelic_plugins_hive.png?branch=master,develop)](https://api.travis-ci.org/elad-maimon/newrelic_plugins_hive.png?branch=master,develop) [![Coverage Status](https://coveralls.io/repos/elad-maimon/newrelic_plugins_hive/badge.png?branch=master)](https://coveralls.io/r/elad-maimon/newrelic_plugins_hive?branch=master,develop) [![endorse](https://api.coderwall.com/elad-maimon/endorsecount.png)](https://coderwall.com/elad-maimon)

Without this gem, if you're using more then one plugin for NewRelic you need to download each plugin, configure it in different files and repositories, deploy it separately and run different process for each plugin (including monitor those processes etc...)
NewRelic Plugins Hive allow you to easily download, configure and deploy multiple NewRelic plugins and run them all in one process!

## Installation

Install the gem:

    $ gem install newrelic_plugins_hive
    
Create a new hive application (this will create a new folder with the name you specified and the default folder structure and files):

	$ hive new <APP_NAME>
    
## Configure the hive

First, you need to configure which New Relic plugins you want to use in the hive.
To do that open the file `config/newrelic_hive.yml` and add for each plugin its github repository and a path to the agent file in the repository.

Example structure of the file:

	plugins:
	  sidekiq:
	    github: https://github.com/eksoverzero/newrelic_sidekiq_agent
	    agent_path: newrelic_sidekiq_agent
	  rabbitmq:
	    github: https://github.com/gopivotal/newrelic_pivotal_agent
	    agent_path: plugins/pivotal_rabbitmq_plugin/pivotal_rabbitmq_plugin.rb
	  redis:
	    github: https://github.com/gopivotal/newrelic_pivotal_agent
	    agent_path: plugins/pivotal_redis_plugin/pivotal_redis_plugin.rb

It is enough that `agent_path` attribute will specify a unique filname in the repository. So in the example above you can just use this `agent_path` for redis:

	agent_path: pivotal_redis_plugin.rb

#### Install the plugins in the hive

This will download and extract the plugin agents that specified in `config/newrelic_hive.yml`:

	$ hive install
	
## Configure each plugin

Configuring the plugins in the hive requires 3 simple steps:

1. Add your New Relic license key to `config/newrelic_plugin.yml`
2. For each plugin, add the plugin specific configuration to `config/newrelic_plugin.yml` under the section `agents`
3. Add additional gems to your Gemfile, if the plugins in the hive require it.

__Example:__ The RabbitMQ plugin has a configuration to specify the rabbitmq url, as well as the Sidekiq plugins that requires the Redis uri, so example `config/newrelic_plugin.yml` will look like:

	newrelic:
	  license_key: 'YOUR_LICENSE_KEY_HERE'
	
	  # Set to '1' for verbose output, remove for normal output.
	  verbose: 1
	
	agents:
	  rabbitmq:
	    management_api_url: http://user:password@hostname:55672
	
	  sidekiq_status_agent:
	    -
	      instance_name: "Name"
	      uri: "redis://localhost:6379"
	      namespace: "namespace"

This example combine in the same `config/newrelic_plugin.yml` configurations from two different plugins (rabbitMQ and Sidekiq).
You must look at your plugin documentation and follow the instructions how to configure it.

## Usage

Run the agent:

	$ hive run
	
Or, as a maemon:

	$ hive run -d start # Start the daemon
	$ hive run -d stop # Stop the daemon
	
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
