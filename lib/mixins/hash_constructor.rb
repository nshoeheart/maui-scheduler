#
# Module HashConstructor provides Module to automate class attribute assignments from a hash, most likely parsed from JSON.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
module HashConstructor
	#
	# Initialize an instance of an object from a hash of its instance variables and their values. Intended for use in converting a hash parsed from JSON to an object.
	#
	# @param [Hash{String => String, #to_s}] hash Hash of the parameters that are to be assigned to the model that uses this initializer.
	#
	def initialize(hash)
		hash.each { |key, val|
			begin
				public_send("#{key}=", val)
			rescue NoMethodError
				#todo possibly add more organized error logging
				#puts "ERROR: Attempted to call undefined method: \"#{key}=\" with value: \"#{val}\""
			end
		}
	end
end