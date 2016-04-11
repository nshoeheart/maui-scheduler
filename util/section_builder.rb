require_relative '../models/maui/complex_section'
require_relative '../models/scheduler/course'
require_relative '../models/scheduler/schedule'

#
# Class SectionBuilder provides a utility to convert a set of courses obtained from MAUI and parse its data format into one that is convenient for this scheduling application. Takes care of fully building Section objects and assigning them to the correct SectionGroup within each Course.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class SectionBuilder
	attr_reader(:maui_courses, :courses)

	#
	# Create a new instance of SectionBuilder and convert the provided MAUI Courses into Course objects that fit this application.
	#
	# @param [Array<MauiCourse>] maui_courses list of MauiCourse objects that will be converted into Course objects
	#
	def initialize(maui_courses)
		@maui_courses = maui_courses
		@courses = []

		@maui_courses.each { |course|
			build_course(course)
		}
	end

	#
	# Build a Course object and populate all its attributes from the provided MauiCourse
	#
	# @param [MauiCourse] maui_course object containing course data as in the format that MAUI provides
	#
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
			full_course_num = "#{subject}:#{course_num}:#{section_num}"
			planner_status = maui_section.plannerStatus
			schedule = Schedule.parse_maui_schedule(maui_section.timeAndLocations, full_course_num, course_title, section_type)
			mand_sec_num = maui_section.mandatorySectionNumber
			mand_sec_group = maui_section.mandatoryGroup

			course.add_section(section_maui_id, section_num, section_type, planner_status, schedule, mand_sec_num, mand_sec_group)
		}

		@courses << course
	end
	private :build_course
end