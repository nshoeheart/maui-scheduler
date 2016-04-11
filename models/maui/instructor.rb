#
# Class Instructor provides Model to hold MAUI data about an instructor for a given course or section.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Instructor
	attr_accessor(:id,
				:firstName,
				:middleName,
				:lastName,
				:edsActive,
				:hawkid,
				:name,
				:fullName,
				:role,
				:iconRole,
				:email,
				:sortOrder,
				:currentStudent,
				:honors)

	include HashConstructor

	#
	# Simple to_str method to print this object for debugging
	#
	#
	# @return [String] String representation of this object
	#
	def to_str
		return ("Instructor:\n" +
				"id = #{id}\n" +
				"firstName = #{firstName}\n" +
				"middleName = #{middleName}\n" +
				"lastName = #{lastName}\n" +
				"edsActive = #{edsActive}\n" +
				"hawkid = #{hawkid}\n" +
				"name = #{name}\n" +
				"fullName = #{fullName}\n" +
				"role = #{role}\n" +
				"iconRole = #{iconRole}\n" +
				"email = #{email}\n" +
				"sortOrder = #{sortOrder}\n" +
				"currentStudent = #{currentStudent}\n" +
				"honors = #{honors}")
	end
end