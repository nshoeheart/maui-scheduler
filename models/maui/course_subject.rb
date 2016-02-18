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
		puts "Course Subject:"
		puts "ID = #{id}"
		puts "Natural Key = #{naturalKey}"
		puts "Sort Order = #{sortOrder}"
		puts "Short Description = #{shortDescription}"
		puts "Web Description = #{webDescription}"
		puts "Description = #{description}"
		puts "Additional Info = #{additionalInfo}"
		puts "Additional Info 1 = #{additionalInfo1}"
		puts "Additional Info 2 = #{additionalInfo2}"
		puts "Additional Info 3 = #{additionalInfo3}"
	end

	#def initialize(id, naturalKey, sortOrder, shortDescription, webDescription, description, additionalInfo, additionalInfo1, additionalInfo2, additionalInfo3)
	#	@id = id
	#	@naturalKey = naturalKey
	#	@sortOrder = sortOrder
	#	@shortDescription = shortDescription
	#	@webDescription = webDescription
	#	@description = description
	#	@additionalInfo = additionalInfo #needs to be an object
	#	@additionalInfo1 = additionalInfo1
	#	@additionalInfo2 = additionalInfo2
	#	@additionalInfo3 = additionalInfo3
	#end
end