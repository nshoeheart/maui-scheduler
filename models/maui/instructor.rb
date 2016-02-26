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