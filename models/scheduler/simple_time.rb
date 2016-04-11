#
# Class SimpleTime provides Class used to parse class times as they are received from UIowa's MAUI web services into a format that is convenient for use in scheduling and comparing Events.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class SimpleTime
	attr_reader :disp_time, :comp_time

	#
	# Create a new instance of SimpleTime using a String received from UIowa's MAUI web services
	#
	# @param [String] time_str String representing a timestamp received from MAUI formatted like: '11:30A' or '12:20P'. Also accepts '16:30'.
	#
	def initialize(time_str)
		if time_str != nil
			time_str = time_str.downcase

			if (time_str.end_with?('a') || time_str.end_with?('p'))
				parse_12hr_time(time_str)
			else
				parse_24hr_time(time_str)
			end
		else
			@disp_time = 'N/A'
			@comp_time = -1
		end
	end

	#
	# Parse a time String such as '11:30A' or '12:20P' in order to fill @disp_time and @comp_time accordingly
	#
	# @param [String] time_str String representation of a timestamp in 12-hr format: 'hh:mm[A|P]'
	#
	def parse_12hr_time(time_str)
		period = time_str[-1..-1]
		time = time_str[0..-2]
		hours = time.split(':')[0].to_i
		mins = time.split(':')[1].to_i

		if period == 'p'
			@disp_time = "#{time} PM"
			hours = (hours < 12 ? hours + 12 : hours)
			@comp_time = hours*60 + mins
		else # period == 'a'
			@disp_time = "#{time} AM"
			hours = (hours == 12 ? hours - 12 : hours)
			@comp_time = hours*60 + mins
		end

		return nil
	end
	private :parse_12hr_time

	#
	# Parse a time String such as '10:30' or '17:38' in order to fill @disp_time and @comp_time accordingly
	#
	# @param [String] time_str String representation of a timestamp in 24-hr format: 'HH:mm'
	#
	def parse_24hr_time(time_str)
		hours = time.split(':')[0].to_i
		mins = time.split(':')[1].to_i
		@comp_time = hours*60 + mins

		if hours > 12
			@disp_time = "#{hours - 12}:#{mins} PM"
		elsif hours == 0
			@disp_time = "#{hours + 12}:#{mins} AM"
		else
			@disp_time = "#{hours}:#{mins} AM"
		end

		return nil
	end
	private :parse_24hr_time

	# Methods for comparing/sorting SimpleTime objects

	def > time
		return (@comp_time > time.comp_time)
	end

	def < time
		return (@comp_time < time.comp_time)
	end

	def == time
		return (@comp_time == time.comp_time)
	end

	def >= time
		return !(self < time)
	end

	def <= time
		return !(self > time)
	end

	def <=> time
		return -1 if self < time
		return 0 if self == time
		return 1 if self > time
	end
end