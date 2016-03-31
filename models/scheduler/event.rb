require_relative 'simple_time'

class Event
	attr_reader(:full_course_num,
				:course_title,
				:event_type,
				:start_time, # SimpleTime object
				:end_time, # SimpleTime object
				:location)

	def initialize(start_time, end_time, full_course_num, course_title, event_type, location)
		@start_time = start_time
		@end_time = end_time
		@full_course_num = full_course_num
		@course_title = course_title
		@event_type = event_type
		@location = location
	end

	# Check if this Event object conflicts with another Event object 'event'
	def conflicts_with?(event)
		return (((@start_time >= event.start_time) && (@start_time <= event.end_time)) || ((@end_time >= event.start_time) && (@end_time <= event.end_time)))
	end

	def clone
		return Event.new(@start_time.clone, @end_time.clone, @full_course_num, @course_title, @event_type, @location)
	end

	def time_and_loc
		return "#{@start_time.disp_time} - #{@end_time.disp_time} in #{location}"
	end

	def to_str
		return "#{time_and_loc} --> #{@full_course_num} #{course_title} #{"(" + event_type + ")" unless event_type == "STANDALONE"}"
	end

	def <=> (other_event)
		return @start_time <=> other_event.start_time
	end
end