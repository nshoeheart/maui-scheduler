require 'rest-client'
require 'json'

require_relative '../lib/extensions/time_extensions'

#
# Class MauiWebServiceUtil provides a utility to make GET API calls to UIowa's public MAUI web services and parse the responses from JSON to a hash
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class MauiWebServiceUtil
	@@base_url = 'https://api.maui.uiowa.edu/maui/api'

	#
	# Make a GET request to @@base_url + url_extension and return a hash of the parsed JSON response
	#
	# @param [String] url_extension extension of the base MAUI url corresponding to the desired web service call
	#
	# @return [Hash] hash of the parsed JSON response
	#
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
