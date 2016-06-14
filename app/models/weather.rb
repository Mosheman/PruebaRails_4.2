class Weather
	# => Class ment to conect to Weather Forecast through Barometer Gem,
	## and helps managing the logic of telling if its going to rain 7 days ahead.
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :forecast, type: Array
  	field :will_rain, type: Boolean, default: false

	def query #geo
		#unless geo.blank?
			# Search for Lat & Lng in @geo 349859
		    # barometer = Barometer.new(geo)
		    # self.measure = barometer ? barometer.measure : nil
		    begin
		    	response = RestClient.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22Santiago%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
			rescue RestClient::ExceptionWithResponse => err
				err.response
			end
			json_response = JSON.parse response
			self.forecast = json_response["query"]["results"]["channel"]["item"]["forecast"]
		#end
	end

	def is_raining_soon_until n_days
		unless self.forecast.blank?
			(1..n_days).each do |day|
				weather_status = self.forecast.blank? ? "" : self.forecast[day]["text"].downcase
				# Expected rain on a given day?
				if /rain/.match(weather_status) or /showers/.match(weather_status)
					self.will_rain = true
					break
				end
			end
			self.will_rain
		end
	end
end