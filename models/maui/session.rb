require_relative '../../lib/mixins/hash_constructor'

class Session
	attr_accessor(:id,
				:startDate,
				:endDate,
				:shortDescription,
				:legacyCode)

	include HashConstructor

	def to_str
		puts "Session:"
		puts "ID = #{id}"
		puts "Start Date = #{startDate}"
		puts "End Date = #{endDate}"
		puts "Short Description = #{shortDescription}"
		puts "Legacy Code = #{legacyCode}"
	end

	#def initialize(id, startDate, endDate, shortDescription, legacyCode)
	#	@id = id
	#	@startDate = startDate
	#	@endDate = endDate
	#	@shortDescription = shortDescription
	#	@legacyCode = legacyCode
	#end
end