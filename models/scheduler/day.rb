#
# Class Day provides Represents a day within a Schedule object's week that contains a list of events that were scheduled.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class Day
	attr_reader(:day_key,
				:events)

	@@sun = 0
	@@mon = 1
	@@tue = 2
	@@wed = 3
	@@thu = 4
	@@fri = 5
	@@sat = 6
	@@day_keys = [@@sun, @@mon, @@tue, @@wed, @@thu, @@fri, @@sat]

	@@tiny_names = {@@sun => 'Su', @@mon => 'Mo', @@tue => 'Tu', @@wed => 'We', @@thu => 'Th', @@fri => 'Fr', @@sat => 'Sa'}
	@@short_names = {@@sun => 'Sun', @@mon => 'Mon', @@tue => 'Tue', @@wed => 'Wed', @@thu => 'Thu', @@fri => 'Fri', @@sat => 'Sat'}
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

	def self.day_keys
		@@day_keys
	end

	#
	# Create an instance of Day identified by its day_key. Events are added separately.
	#
	# @param [Integer] day_key Identifier for the day of the week contained in @@day_keys
	#
	def initialize(day_key)
		if (Day.day_keys.include?(day_key))
			@day_key = day_key
		else
			@day_key = nil #todo - throw error instead?
		end

		@events = []
	end

	# Check if this Day object conflicts with another Day object 'day'
	#
	# Check if the events contained within this Day object could be merged with those of another Day object without any overlaps
	#
	# @param [Day] day Other day to check for conflicts with this day
	#
	# @return [Boolean] whether or nor there would be conflicting events caused by merging the two Days together
	#
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

	#
	# Merge the events of another Day object into this one. It is recommended to check for conflicts using #conflicts_with? prior to merging.
	#
	# @param [Day] day Day object whose events will be added to this Day's events
	#
	# @return [Day] The updated instance of this Day
	#
	def merge(day)
		day.events.each { |event|
			add_event(event)
		}
		@events.sort!

		return self
	end

	#
	# Create a clone of this Day object that is entirely new in memory; it has no pointers to this object or its attributes.
	#
	#
	# @return [Day] An entirely new instance of this Day object in memory.
	#
	def clone
		day_clone = Day.new(@day_key)

		@events.each { |event|
			event_clone = event.clone
			day_clone.add_event(event_clone)
		}

		return day_clone
	end

	#
	# Add a new Event object to the list of events contained in this instance of Day
	#
	# @param [Event] event Event object to add to this Day
	#
	# @return [Day] updated instance of this Day
	#
	def add_event(event)
		@events << event
		@events.sort!

		return self
	end

	#
	# Get the tiny (2-character) name for this day contained in @@tiny_names
	#
	#
	# @return [String] 2-character name for this day
	#
	def tiny_name
		@@tiny_names[@day_key]
	end

	#
	# Get the short (3-character) name for this day contained in @@short_names
	#
	#
	# @return [String] 3-character name for this day
	#
	def short_name
		@@short_names[@day_key]
	end

	#
	# Get the full name for this day contained in @@long_names
	#
	#
	# @return [String] Full/long name for this day
	#
	def long_name
		@@long_names[@day_key]
	end
end