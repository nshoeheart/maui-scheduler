require_relative '../../lib/mixins/hash_constructor'

class Session
	attr_accessor(:id,
				:startDate,
				:endDate,
				:shortDescription,
				:legacyCode)

	include HashConstructor

	def to_str
		return ("Session:\n" +
				"ID = #{id}\n" +
				"Start Date = #{startDate}\n" +
				"End Date = #{endDate}\n" +
				"Short Description = #{shortDescription}\n" +
				"Legacy Code = #{legacyCode}")
	end
end