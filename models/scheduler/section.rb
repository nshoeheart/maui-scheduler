class Section
	attr_accessor(:maui_id,
				:course_title,
				:subject,
				:course_num,
				:section_num,
				:section_type, # lecture, discussion, lab, etc. (enum?)
				:planner_status, # make sure it is an approved section
				:schedule) # Schedule object

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

	def full_section_num
		return "#{subject}:#{course_num}:#{section_num}"
	end
end