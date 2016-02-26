class Section
	attr_reader(:course_title,
				:subject,
				:course_num,
				:section_num,
				:section_type, # lecture, discussion, lab, etc. (enum?)
				:schedule, # split out into separate model
				:planner_status) # make sure it is an approved section
end