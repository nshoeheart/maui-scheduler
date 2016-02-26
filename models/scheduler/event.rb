class Event
	attr_reader(:start_time,
				:end_time,
				:course_number,
				:course_title,
				:event_type)

	def initialize(start_time, end_time, course_number, course_title, event_type)
		@start_time = start_time
		@end_time = end_time
		@course_number = course_number
		@course_title = course_title
		@event_type = event_type
	end

	# Check if this Event object conflicts with another Event object 'event'
	def conflicts_with?(event)
		# todo improve logic using a Time method if these are Date/Time objects
		if (((@start_time >= event.start_time) && (@start_time <= event.end_time)) || ((@end_time >= event.start_time) && (@end_time <= event.end_time)))
			return true
		end

		return false
	end
end