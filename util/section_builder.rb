require_relative '../models/maui/complex_section'
require_relative '../models/scheduler/course'
require_relative '../models/scheduler/schedule'

class SectionBuilder
	attr_reader(:maui_courses, :courses)

	def initialize(maui_courses)
		@maui_courses = maui_courses
		@courses = []

		@maui_courses.each { |course|
			build_course(course)
		}
	end

	def build_course(maui_course)
		course = nil

		maui_course.each { |maui_section|
			course_title = maui_section.courseTitle
			subject = maui_section.subjectCourse.split(":")[0];
			course_num = maui_section.subjectCourse.split(":")[1];

			if course == nil
				course_maui_id = maui_section.courseId
				course = Course.new(course_maui_id, course_title, subject, course_num)
			end

			section_maui_id = maui_section.sectionId
			section_num = maui_section.sectionNumber
			section_type = maui_section.sectionType
			planner_status = maui_section.plannerStatus
			schedule = Schedule.parse_maui_schedule(maui_section.timeAndLocations[0]) #todo Is there ever more than 1 of these?
			mand_sec_num = maui_section.mandatorySectionNumber
			mand_sec_group = maui_section.mandatoryGroup

			course.add_section(section_maui_id, section_num, section_type, planner_status, schedule, mand_sec_num, mand_sec_group)
		}

		@courses << course
	end
end