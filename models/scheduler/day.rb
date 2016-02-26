class Day
	attr_reader(:day,
				:events)

	@@mon = :mon
	@@tue = :tue
	@@wed = :wed
	@@thu = :thu
	@@fri = :fri
	@@sat = :sat
	@@sun = :sun

	def initialize(day_name)
		if (day_names.includes?(day_name))
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
	end

	def add_event(event)
		@events << event
	end

	def self.day_names
		return [@@mon, @@tue, @@wed, @@thu, @@fri, @@sat, @@sun]
	end
end