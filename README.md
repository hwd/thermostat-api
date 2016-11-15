# thermostat-api

A Ruby API library for Netatmo Thermostat (unofficial)

_This project and the code was not created and not supported by Netatmo. I wrote this gem for myself, so I can not guarantee it will work in all cases._

## Installation

Clone the repository and add this line to your application's Gemfile:

```ruby
gem 'thermostat-api', path: '/path/of/the/repository'
```

And then execute:

    $ bundle

## Configure

```ruby
ThermostatAPI.configure do |config|
  config.client_id = 'NETATMO_CLIENT_ID'
  config.client_secret = 'NETATMO_CLIENT_SECRET'
  config.username = 'NETATMO_EMAIL'
  config.password = 'NETATMO_PASSWORD'
  config.scope = 'read_station read_thermostat write_thermostat'
end
```

Or use ENV vars:

```bash
ENV['NETATMO_CLIENT_ID']
ENV['NETATMO_CLIENT_SECRET']
ENV['NETATMO_EMAIL']
ENV['NETATMO_PASSWORD']
```

## Usage

```ruby
thermostat = ThermostatAPI::Thermostat.new

# Get current temperature
thermostat.temperature

# Get desired temperature
thermostat.setpoint_temp

# Start/stop boiler
thermostat.on!
thermostat.off!

# Set the thermostat in auto mode (program)
thermostat.auto!

# Set the thermostat in away mode
thermostat.away!

# Set the thermostat in frost protection mode
thermostat.protect_frost!

# Set temperature (default for 3 hours)
thermostat.set_temp(22)

# Set temperature for 1 hour
thermostat.set_temp(22, 1)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hwd/thermostat-api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

