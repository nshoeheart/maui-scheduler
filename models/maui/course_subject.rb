require_relative '../../lib/mixins/hash_constructor'

class CourseSubject
	attr_accessor(:id,
				:naturalKey,
				:sortOrder,
				:shortDescription,
				:webDescription,
				:description,
				:additionalInfo, # this will contain an AdditionalInfo object
				:additionalInfo1,
				:additionalInfo2,
				:additionalInfo3)

	include HashConstructor

	def to_str
		return ("Course Subject:\n" +
				"ID = #{id}\n" +
				"Natural Key = #{naturalKey}\n" +
				"Sort Order = #{sortOrder}\n" +
				"Short Description = #{shortDescription}\n" +
				"Web Description = #{webDescription}\n" +
				"Description = #{description}\n" +
				"Additional Info = #{additionalInfo}\n" +
				"Additional Info 1 = #{additionalInfo1}\n" +
				"Additional Info 2 = #{additionalInfo2}\n" +
				"Additional Info 3 = #{additionalInfo3}")
	end
end