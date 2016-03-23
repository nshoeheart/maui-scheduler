require_relative 'day'
require_relative 'event'
require_relative 'simple_time'
require_relative '../maui/complex_section'

class Schedule
	attr_reader(:days)

	def initialize
		@days = Hash.new
	end

	def self.parse_maui_schedule(times_and_locations, course_num, course_title, event_type) # array of timeAndLocations objects
		schedule = Schedule.new

		times_and_locations.each { |tal|
			days = []

			start_time = SimpleTime.new(tal.startTime)
			end_time = SimpleTime.new(tal.endTime)
			location = "#{tal.room} #{tal.building}"
			event = Event.new(start_time, end_time, course_num, course_title, event_type, location)

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

				if schedule.days.has_key?(day.day_name)
					day.merge(schedule.days[day.day_name])
					schedule.add_day(day)
				else
					schedule.add_day(day)
				end
			}
		}

		return schedule
	end

	def add_day(day)
		@days[day.day_name] = day
	end

	# Check if this Schedule object has any conflicts with another Schedule object 'sch'
	def conflicts_with?(sch)
		Day.day_names.each { |day_name|
			if @days.has_key?(day_name) && sch.days.has_key?(day_name)
				if (@days[day_name].conflicts_with? sch.days[day_name])
					return true
				end
			end
		}

		return false
	end

	# Merge another Schedule object into this one
	# To avoid overlapping events, make sure that conflicts_with?(sch) returns false
	def merge(sch)
		sch.days.each { |day|
			if (@days.has_key?(day.day_name))
				@days[day.day_name].merge(day)
			else
				@days[day.day_name] = day
			end
		}
	end
end