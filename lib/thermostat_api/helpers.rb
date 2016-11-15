require 'thermostat_api/thermostat'

module ThermostatAPI::Helpers

  DEFAULT_MANUAL_TEMP_DURATION = 3

  def temperature
    state['measured']['temperature']
  end

  def setpoint_temp
    state['measured']['setpoint_temp']
  end

  def on?
    state['therm_relay_cmd'] > 0
  end

  def off?
    state['setpoint']['setpoint_mode'] == 'off'
  end

  def away?
    state['setpoint']['setpoint_mode'] == 'away'
  end

  def auto?
    state['setpoint']['setpoint_mode'] == 'program'
  end

  def frost_protected?
    state['setpoint']['setpoint_mode'] == 'hg'
  end

  def away!
    return 'already in away mode' if away?
    set_therm(setpoint_mode: 'away')
  end

  def off!
    return 'already off' if off?
    set_therm(setpoint_mode: 'off')
  end

  def auto!
    return 'already in auto mode (program)' if auto?
    set_therm(setpoint_mode: 'program')
  end
  alias_method :on!, :auto!

  def protect_frost!
    return 'already in frost protection mode' if frost_protected?
    set_therm(setpoint_mode: 'hg')
  end

  def set_temp(temp, duration = DEFAULT_MANUAL_TEMP_DURATION)
    duration = (Time.now + (duration * 60 * 60)).to_i

    query = {
      setpoint_mode: 'manual',
      setpoint_temp: temp,
      setpoint_endtime: duration
    }

    set_therm(query)
  end

end
