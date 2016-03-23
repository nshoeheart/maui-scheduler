class SimpleTime
	attr_reader :disp_time, :comp_time

	def initialize(time_str)
		time_str = time_str.downcase
		
		if (time_str.end_with?('a') || time_str.end_with?('p'))
			@time = parse_12hr_time(time_str)
		else
			@time = parse_24hr_time(time_str)
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
end