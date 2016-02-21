module HashConstructor
	def initialize(hash)
		hash.each { |key, val|
			public_send("#{key}=", val)
		}
	end
end