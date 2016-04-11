require_relative '../../lib/mixins/hash_constructor'

#
# Class Session provides Model to hold MAUI data about a session/semester/term (such as 20158 - Spring 2016).
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Session
	attr_accessor(:id,
				:startDate,
				:endDate,
				:shortDescription,
				:legacyCode)

	include HashConstructor

	#
	# Simple to_str method to print this object for debugging
	#
	#
	# @return [String] String representation of this object
	#
	def to_str
		return ("Session:\n" +
				"ID = #{id}\n" +
				"Start Date = #{startDate}\n" +
				"End Date = #{endDate}\n" +
				"Short Description = #{shortDescription}\n" +
				"Legacy Code = #{legacyCode}")
	end
end