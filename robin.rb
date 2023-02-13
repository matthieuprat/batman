require 'httparty'

# Docs: https://docs.robinpowered.com/reference/
class Robin
  include HTTParty

  ZONES = {
    wandsworth: '206733'
  }

  base_uri 'api.robinpowered.com/v1.0'
  headers({
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          })
  format :json

  def initialize(access_token)
    @headers = {
      'Authorization' => "Access-Token #{access_token}"
    }
  end

  # logger ::Logger.new STDERR
  # debug_output $stderr

  def auth
    self.class.get('/auth', headers: @headers)
  end

  # https://docs.robinpowered.com/reference/reserve-desks
  def book_seat(id, email, start_time = nil, end_time = nil)
    start_time ||= DateTime.parse(Date.today.to_s + 'T' + '08:00:00Z')
    end_time ||= DateTime.parse(start_time.to_date.to_s + 'T' + '18:00:00Z')

    self.class.post("/seats/#{id}/reservations", body: {
      start: {
        date_time: start_time.iso8601,
        time_zone: 'Europe/London'
      },
      end: {
        date_time: end_time.iso8601,
        time_zone: 'Europe/London'
      },
      reservee: {
        email:
      },
      type: 'hot' # or 'hoteled'
    }.to_json, headers: @headers)
  end

  def seats(zone_id)
    zone_id = ZONES.fetch(zone_id) if zone_id.is_a?(Symbol)
    self.class.get("/zones/#{zone_id}/seats", query: { per_page: 100 }, headers: @headers)
  end

  # Retry requests
  def self.perform_request(http_method, path, options, &block)
    tries = 3
    begin
      super
    rescue StandardError => e
      sleep 1
      raise unless (tries -= 1) > 0

      retry
    end
  end
end
