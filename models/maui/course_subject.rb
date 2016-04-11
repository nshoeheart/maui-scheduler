require_relative '../../lib/mixins/hash_constructor'

#
# Class CourseSubject provides Model to store MAUI data about a CourseSubject object, which reprents a course type such as CBE, ECON, CS, etc.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
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

	#
	# Simple to_str method to print this object for debugging.
	#
	#
	# @return [String] String representation of this object
	#
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