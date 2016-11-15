require 'thermostat_api/thermostat'

module ThermostatAPI::Public

  def public_data(params)
    query = {
      lat_ne: params[:lat_ne],
      lon_ne: params[:lon_ne],
      lat_sw: params[:lat_sw],
      lon_sw: params[:lon_sw]
    }

    @session.get(:getpublicdata, query)
  end

end
