require_relative 'day'
require_relative 'event'

class Schedule
	attr_reader(:days)

	def initialize
		@days = Hash.new

		Day.day_names.each { |d|
			@days[d] = Day.new(d)
		}
	end

	def self.parse_maui_schedule(tal)
		schedule = Schedule.new

		# todo add parsing logic from timeAndLocations object to Schedule

		return schedule
	end

	# Check if this Schedule object has any conflicts with another Schedule object 'sch'
	def conflicts_with?(sch)
		sch.days.each { |day|
			if (@days[day.day_name].conflicts_with?(day))
				return true
			end
		}

		return false
	end

	# Merge another Schedule object into this one
	# To avoid overlapping events, make sure that conflicts_with?(sch) returns false
	def merge(sch)
		sch.days.each { |day|
			@days[day.day_name.merge(day)]
		}
	end
end