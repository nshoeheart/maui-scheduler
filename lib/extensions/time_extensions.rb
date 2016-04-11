#
# Class Time provides Extensions to Ruby's default Time class
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Time
	#
	# Convert the current Time object to an int representing the number of milliseconds since the Epoch
	#
	# @return [Integer] The number or milliseconds elapsed between the Epoch and this Time instance
	#
	def to_ms
		(self.to_f * 1000.0).to_i
	end
end