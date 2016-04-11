#
# Class Section provides Individual section of a course that can be represented by a unique section number for its semester.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Section
	attr_accessor(:maui_id,
				:course_title,
				:subject,
				:course_num,
				:section_num,
				:section_type, # lecture, discussion, lab, etc. (enum?)
				:planner_status, # make sure it is an approved section
				:schedule) # Schedule object

	#
	# Create a new instance of Section
	#
	# @param [Integer] maui_id ID number for this section within UIowa's MAUI web services
	# @param [String] course_title Full title/name of this course
	# @param [String] subject Subject identifier for this course, such as CBE, RHET, CS, ECON, etc.
	# @param [Integer] course_num Course number that would be found within a full course number as follows: SUBJ:COURSE_NUM:SECTION_NUM
	# @param [String] section_num Section number that is unique to this section within this course for the given semester
	# @param [String] section_type The type of this section, such as LECTURE, DISCUSSION, STANDALONE, etc.
	# @param [Schedule] schedule A fully built Schedule object representing the times and locations of the events specific to this section
	# @param [String] planner_status status of this section according to the planner, such as APPROVED
	#
	def initialize(maui_id, course_title, subject, course_num, section_num, section_type, schedule, planner_status)
		@maui_id = maui_id
		@course_title = course_title
		@subject = subject
		@course_num = course_num
		@section_num = section_num
		@section_type = section_type
		@schedule = schedule
		@planner_status = planner_status
	end

	#
	# Generate and return the full section number of this Section as it would be found in the Iowa course catalog
	#
	#
	# @return [String] Full section number of the format <subject>:<course_num>:<section_num>
	#
	def full_section_num
		return "#{subject}:#{course_num}:#{section_num}"
	end
end