require_relative 'section_group'
require_relative 'section'

class Course
	attr_reader(:maui_id,
				:course_title,
				:subject,
				:course_num,
				:section_groups)

	def initialize(maui_id, course_title, subject, course_num)
		@maui_id = maui_id
		@course_title = course_title
		@subject = subject
		@course_num = course_num
		@section_groups = []
	end
	
	def add_section(maui_id, section_num, section_type, planner_status, schedule, mand_sec_num=nil, mand_group_ids=nil)
		section = Section.new(maui_id, @course_title, @subject, @course_num, section_num, section_type, schedule, planner_status)
		added = false

		@section_groups.each { |group|
			if group.is_eligible_section?(section)
				if group.has_section?(section)
					added = true
					break
				else
					group.add_section(section)
					added = true
					break
				end
			end
		}

		if !added
			group = SectionGroup.new(mand_sec_num, mand_group_ids)
			group.add_section(section)
			@section_groups << group
		end
	end
end