require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

      url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address


    require 'open-uri'

    raw_data = open(url).read

    require 'json'

    parsed_data = JSON.parse(raw_data)


    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude

    @longitude = longitude


    url1 = "https://api.forecast.io/forecast/2462a240cee0a59f9f00cfc43afaf7c7/" + latitude.to_s + "," + longitude.to_s

    require 'open-uri'

    raw_data1 = open(url1).read

    require 'json'

    parsed_data1 = JSON.parse(raw_data1)



    @current_temperature = parsed_data1["currently"]["temperature"]


    @current_summary = parsed_data1["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data1["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data1["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data1["daily"]["summary"]




    render("street_to_weather.html.erb")
  end
end
