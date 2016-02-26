require_relative 'section_group'
require_relative 'section'

class Course
	attr_reader(:course_title,
				:subject,
				:course_num,
				:section_groups)
end