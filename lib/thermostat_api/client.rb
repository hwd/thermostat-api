module ThermostatAPI
  class Client

    BASE_URI = 'https://api.netatmo.com'

    def initialize
      @client_id = ThermostatAPI.configuration.client_id || ENV['NETATMO_CLIENT_ID']
      @client_secret = ThermostatAPI.configuration.client_secret || ENV['NETATMO_CLIENT_SECRET']
      @username = ThermostatAPI.configuration.username || ENV['NETATMO_EMAIL']
      @password = ThermostatAPI.configuration.password || ENV['NETATMO_PASSWORD']
      @scope = ThermostatAPI.configuration.scope || 'read_station read_thermostat'
      @token_uri = '/oauth2/token'
    end

    def get(method, query = {})
      request(:get, method, query)
    end

    def post(method, query = {})
      request(:post, method, query)
    end

    private

    def request(http_method, method, query = {})
      query = { access_token: token }.merge(query)
      response = HTTParty.send(http_method, "#{BASE_URI}/api/#{method}", query: query)
      response['body'] || response['status']
    end

    def token
      @token && !valid_token? ? refresh_token : get_token
    end

    def get_token
      body = {
        grant_type: 'password',
        username: @username,
        password: @password,
        scope: @scope
      }.merge(client_params)

      response = token_request(body)

      @refresh_token = response['refresh_token']
      @expire_in = Time.now + response['expire_in']
      @token = response['access_token']
    end

    def refresh_token
      body = {
        grant_type: 'refresh_token',
        refresh_token: @refresh_token
      }.merge(client_params)

      response = token_request(body)

      @expire_in = Time.now + response['expire_in']
      @token = response['access_token']
    end

    def token_request(body)
      HTTParty.post(BASE_URI + @token_uri, body: body)
    end

    def valid_token?
      Time.now < @expire_in
    end

    def client_params
      { client_id: @client_id, client_secret: @client_secret }
    end

  end
end