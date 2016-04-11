require_relative 'section_group'
require_relative 'section'

#
# Class Course provides Information about a UI course, which contains basic descriptive info in addition to a list of children section groups.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Course
	attr_reader(:maui_id,
				:course_title,
				:subject,
				:course_num,
				:section_groups) # array of SectionGroup objects

	#
	# Initializer for building a Course object with its basic descriptive information. Sections are added separately.
	#
	# @param [Integer] maui_id ID number of the Course in MAUI
	# @param [String] course_title Name/Title of the Course in MAUI
	# @param [String] subject Subject or course type, such as CBE, CS, ENGR, ECON, etc.
	# @param [Integer] course_num Course number according to MAUI, NOT including a section number
	#
	def initialize(maui_id, course_title, subject, course_num)
		@maui_id = maui_id
		@course_title = course_title
		@subject = subject
		@course_num = course_num
		@section_groups = []
	end

	#
	# Build a child section object using the provided parameters and assign it to the correct section group in accordance with mandatory section guidelines.
	#
	# @param [Integer] maui_id ID number of the Section in MAUI
	# @param [String] section_num Section number specific to this section (unique within scope of the course)
	# @param [String] section_type Type of this section, such as LECTURE, DISCUSSION, STANDALONE, etc.
	# @param [String] planner_status Status of this section, such as APPROVED
	# @param [Schedule] schedule Schedule object representing the weekly times and locations of classes for this section
	# @param [String] mand_sec_num Mandatory section number that this section must be concurrently enrolled with, if provided
	# @param [Array<Integer>] mand_group_ids List of the MAUI ID numbers of sections within the same mandatory section group
	#
	# @return [Course] updated instance of this Course
	#
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

		return self
	end

	#
	# Populate and return a list of the possible schedules for enrolling in this course
	#
	#
	# @return [Array<Schedule>] List of Schedule objects for each possible schedule combination in this course
	#
	def get_possible_schedules
		schedules = []

		@section_groups.each { |sg|
			sg.get_possible_schedules.each { |schedule|
				schedules << schedule
			}
		}

		return schedules
	end
end