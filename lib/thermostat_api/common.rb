require 'thermostat_api/thermostat'

module ThermostatAPI::Common

  def user
    @session.get(:getuser)
  end

  def device(id)
    devices['devices'].select { |k| /^#{id}$/i.match(k['_id']) }.first
  end

  def device_by_name(name)
    devices['devices'].select { |k| /^#{name}$/i.match(k['station_name']) }.first
  end

  def devices
    query = { app_type: 'app_thermostat' }
    @session.get(:devicelist, query)
  end

  def measures(params = {})
    query = {
      device_id: @station_id,
      module_id: @relay_id,
      type: 'Temperature',
      scale: '1hour',
      optimize: false
    }.merge(params)

    @session.get(:getmeasure, query)
  end

  def add_webhook(url, app_type)
    query = { url: url, app_type: app_type }
    @session.get(:addwebhook, query)
  end

  def drop_webhook(app_type)
    query = { app_type: app_type }
    @session.get(:dropwebhook, query)
  end

end
