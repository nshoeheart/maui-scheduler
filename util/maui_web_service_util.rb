require 'rest-client'
require 'json'

require_relative '../lib/extensions/time_extensions'

class MauiWebServiceUtil
	@@base_url = 'https://api.maui.uiowa.edu/maui/api'

	def self.get(url_extension)
		get_url = @@base_url + url_extension
		#puts "Making web service call to: #{get_url}"

		start = Time.now
		response = RestClient.get(get_url, :accept => :json)
		time = Time.now.to_ms - start.to_ms

		#puts "Web service call to: #{get_url} completed in: #{time} ms with response code: #{response.code}"
		return JSON.parse(response.to_str)
	end
end
