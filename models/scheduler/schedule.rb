require_relative 'day'
require_relative 'event'
require_relative 'simple_time'
require_relative '../maui/complex_section'

#
# Class Schedule provides container for organizing a weekly-repeating schedule. Organized by a set of up to 7 days, each of which containing a list of events for that day.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Schedule
	attr_reader(:days)

	#
	# Create a new instance of Schedule. Adding days and events are taken care of separately.
	#
	def initialize
		@days = Hash.new
	end

	#
	# Parse a TimeAndLocations object from UIowa's MAUI webservices into a new Schedule instance along with some other descriptive information.
	#
	# @param [ComplexSection::TimeAndLocation] times_and_locations TimeAndLocation object contained within a ComplexSection received from MAUI - contains all necessary scheduling information
	# @param [String] full_course_num Full course number for a section, formatted like: SUBJ:CRSN:SECN
	# @param [String] course_title Title or name of the course whose TimeAndLocation data was passed
	# @param [String] event_type Type of the event whose TimeAndLocation data was passed, such as LECTURE, DISCUSSION, or STANDALONE
	#
	# @return [Schedule] New instance of Schedule populated with Days containing Events according to the information passed in times_and_locations
	#
	def self.parse_maui_schedule(times_and_locations, full_course_num, course_title, event_type) # array of timeAndLocations objects
		schedule = Schedule.new

		times_and_locations.each { |tal|
			days = []

			start_time = SimpleTime.new(tal.startTime)
			end_time = SimpleTime.new(tal.endTime)
			location = "#{tal.room} #{tal.building}"
			event = Event.new(start_time, end_time, full_course_num, course_title, event_type, location)

			if tal.sun
				days << Day.new(Day.sun)
			end
			if tal.mon
				days << Day.new(Day.mon)
			end
			if tal.tue
				days << Day.new(Day.tue)
			end
			if tal.wed
				days << Day.new(Day.wed)
			end
			if tal.thu
				days << Day.new(Day.thu)
			end
			if tal.fri
				days << Day.new(Day.fri)
			end
			if tal.sat
				days << Day.new(Day.sat)
			end

			days.each { |day|
				day.add_event(event)

				if schedule.days.has_key?(day.day_key)
					day.merge(schedule.days[day.day_key])
					schedule.add_day(day)
				else
					schedule.add_day(day)
				end
			}
		}

		return schedule
	end

	#
	# Add a new Day object to this Schedule instance. If there is already a Day at @days[day.day_key], it will be replaced by the Day provided.
	#
	# @param [Day] day Day object to be placed in @days[day.day_key]
	#
	# @return [Schedule] updated instance of this Schedule
	#
	def add_day(day)
		@days[day.day_key] = day
		@days = @days.sort.to_h

		return self
	end

	#
	# Check if this Schedule object has any event conflicts with the provided Schedule object
	#
	# @param [Schedule] sch Other Schedule instance on which to check for event conflicts with this Schedule
	#
	# @return [Boolean] Whether or not the provided Schedule has any event conflicts with this Schedule
	#
	def conflicts_with?(sch)
		Day.day_keys.each { |day_key|
			if @days.has_key?(day_key) && sch.days.has_key?(day_key)
				if (@days[day_key].conflicts_with? sch.days[day_key])
					return true
				end
			end
		}

		return false
	end

	#
	# Merge the Days and Events of another Schedule object into this Schedule. To avoid overlapping events, make sure that self.conflicts_with?(sch) returns false before merging.
	#
	# @param [Schedule] sch Other instance of Schedule to merge into this instance
	#
	# @return [Schedule] Updated instance of this Schedule
	#
	def merge(sch)
		sch.days.each { |day_key, day|
			if (@days.has_key?(day_key))
				@days[day_key].merge(day)
			else
				@days[day_key] = day
				@days = @days.sort.to_h
			end
		}

		return self
	end

	#
	# Create an identical instance of this Schedule that is independent in memory
	#
	#
	# @return [Schedule] An memory-independent/unreferenced clone of this Schedule
	#
	def clone
		sch_clone = Schedule.new

		@days.each { |day_key, day|
			day_clone = day.clone
			sch_clone.add_day(day_clone)
		}

		return sch_clone
	end

	#
	# Print out a basic text representation of this schedule, organized by each day.
	#
	def print
		@days.each { |day_key, day|
			puts "#{day.long_name}:"

			day.events.each { |event|
				puts "\t#{event.to_str}"
			}
		}

		return nil
	end
end