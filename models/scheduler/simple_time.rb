class SimpleTime
	attr_reader :disp_time, :comp_time

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
	end
	private :parse_12hr_time

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
	end
	private :parse_24hr_time

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