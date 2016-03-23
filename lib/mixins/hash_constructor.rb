module HashConstructor
	def initialize(hash)
		hash.each { |key, val|
			begin
				public_send("#{key}=", val)
			rescue NoMethodError
				#todo add more organized error logging
				#puts "ERROR: Attempted to call undefined method: \"#{key}=\" with value: \"#{val}\""
			end
		}
	end
end