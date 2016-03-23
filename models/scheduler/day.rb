class Day
	attr_reader(:day_name,
				:events)

	@@sun = 'Sun'
	@@mon = 'Mon'
	@@tue = 'Tue'
	@@wed = 'Wed'
	@@thu = 'Thu'
	@@fri = 'Fri'
	@@sat = 'Sat'
	@@day_names = [@@sun, @@mon, @@tue, @@wed, @@thu, @@fri, @@sat]

	@@tiny_names = {@@sun => 'Su', @@mon => 'Mo', @@tue => 'Tu', @@wed => 'We', @@thu => 'Th', @@fri => 'Fr', @@sat => 'Sa'}
	@@long_names = {@@sun => 'Sunday', @@mon => 'Monday', @@tue => 'Tuesday', @@wed => 'Wednesday', @@thu => 'Thursday', @@fri => 'Friday', @@sat => 'Saturday'}

	def self.sun
		@@sun
	end

	def self.mon
		@@mon
	end

	def self.tue
		@@tue
	end

	def self.wed
		@@wed
	end

	def self.thu
		@@thu
	end

	def self.fri
		@@fri
	end

	def self.sat
		@@sat
	end

	def self.day_names
		@@day_names
	end

	def initialize(day_name)
		if (Day.day_names.include?(day_name))
			@day_name = day_name
		else
			@day_name = nil #todo - throw error instead?
		end

		@events = []
	end

	# Check if this Day object conflicts with another Day object 'day'
	def conflicts_with?(day)
		if (day.events.length == 0 || @events.length == 0)
			return false
		end

		day.events.each { |event_a|
			@events.each { |event_b|
				if (event_a.conflicts_with?(event_b))
					return true
				end
			}
		}

		return false
	end

	# Merge another Day object into this one
	# To avoid overlapping events, make sure that conflicts_with?(day) returns false
	def merge(day)
		day.events.each { |event|
			add_event(event)
		}
		@events.sort!
	end

	def add_event(event)
		@events << event
	end

	def tiny_name
		@@tiny_names[@day_name]
	end

	def short_name
		@day_name
	end

	def long_name
		@@long_names[@day_name]
	end
end