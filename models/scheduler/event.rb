require_relative 'simple_time'

#
# Class Event provides a container for information about a course event, such as a lecture or discussion section. Includes basic descriptive information in addition to times and a location.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Event
	attr_reader(:full_course_num,
				:course_title,
				:event_type,
				:start_time, # SimpleTime object
				:end_time, # SimpleTime object
				:location)

	#
	# Create a new Event instance
	#
	# @param [SimpleTime] start_time The time that this event begins, held in a SimpleTime model
	# @param [SimpleTime] end_time The time that this event ends, held in a SimpleTime model
	# @param [String] full_course_num Unique full course number for a specific section, of the format "SUBJ:COUR:SECN"
	# @param [String] course_title Name of the course that this event corresponds to
	# @param [String] event_type Type of this course event, such as discussion, lecture, standalone
	# @param [String] location Where this event will be held, usually in the format of "<Room Number> <Building>"
	#
	def initialize(start_time, end_time, full_course_num, course_title, event_type, location)
		@start_time = start_time
		@end_time = end_time
		@full_course_num = full_course_num
		@course_title = course_title
		@event_type = event_type
		@location = location
	end

	# Check if this Event object conflicts with another Event object 'event'

	#
	# Determine if this Event's timespan overlaps with that of the provided Event object.
	#
	# @param [Event] event The event to check against this event for a conflict
	#
	# @return [Boolean] True if there is a time overlap, false if no conflict
	#
	def conflicts_with?(event)
		return (((@start_time >= event.start_time) && (@start_time <= event.end_time)) || ((@end_time >= event.start_time) && (@end_time <= event.end_time)))
	end

	#
	# Create a clone of this Event object that is unassociated with this Event instance or its attributes in memory.
	#
	#
	# @return [Event] a clone of this Event instance
	#
	def clone
		return Event.new(@start_time.clone, @end_time.clone, @full_course_num, @course_title, @event_type, @location)
	end

	#
	# Get a short, formatted description of the start time, end time, and location of this event
	#
	#
	# @return [String] A brief event description of the format: "<Start Time> - <End Time> in <Location>"
	#
	def time_and_loc
		return "#{@start_time.disp_time} - #{@end_time.disp_time} in #{location}"
	end

	#
	# Get a one-line String representation of this event
	#
	#
	# @return [String] Text representation of this event of the format: "<Start Time> - <End Time> in <Location> --> <Course Number> <Course Title> <Event Type>"
	#
	def to_str
		return "#{time_and_loc} --> #{@full_course_num} #{course_title} #{"(" + event_type.capitalize + ")" unless event_type == "STANDALONE"}"
	end

	#
	# Compare this event to another event for ordering purposes. Events with an earlier start time will be ordered first.
	#
	# @param [Event] other_event Other Event object to compare this Event to
	#
	# @return [Integer] -1, 1, or 0 representing if this event should be ordered before, after, or equivalent to the other event
	#
	def <=> (other_event)
		return @start_time <=> other_event.start_time
	end
end