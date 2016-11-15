module ThermostatAPI

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :username, :password, :scope

    def initialize
      @client_id = ENV['NETATMO_CLIENT_ID']
      @client_secret = ENV['NETATMO_CLIENT_SECRET']
      @username = ENV['NETATMO_EMAIL']
      @password = ENV['NETATMO_PASSWORD']
      @scope = 'read_station read_thermostat write_thermostat'
    end
  end

end