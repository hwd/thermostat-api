require 'thermostat_api/common'
require 'thermostat_api/public'
require 'thermostat_api/helpers'

module ThermostatAPI
  class Thermostat

    include Common
    include Public
    include Helpers

    def initialize(params = {})
      @session = Client.new
      device = set_device(params)
      @station_id = device['_id']
      @relay_id = device['modules'].first
    end

    def state
      @session.get(:getthermstate, thermostat_params)
    end

    def schedule(params)
      query = {
        zones: params[:zones],
        timetable: params[:timetable]
      }.merge(thermostat_params)

      @session.post(:syncschedule, query)
    end

    def data
      query = { device_id: @station_id }
      @session.get(:getthermostatsdata, query)
    end

    def set_therm(params)
      query = params.merge(thermostat_params)
      @session.post(:setthermpoint, query)
    end

    def change_planning(schedule_id)
      query = { schedule_id: schedule_id }.merge(thermostat_params)
      @session.post(:switchschedule, query)
    end

    def create_schedule(params)
      query = {
        zones: params[:zone],
        timetable: params[:timetable],
        name: params[:name]
      }.merge(thermostat_params)

      @session.post(:createnewschedule, query)
    end

    private

    def thermostat_params
      {
        device_id: @station_id,
        module_id: @relay_id
      }
    end

    def set_device(params)
      if params[:name]
        device_by_name(params[:name])
      elsif params[:id]
        device(params[:id])
      else
        devices['devices'].first
      end
    end

  end
end
