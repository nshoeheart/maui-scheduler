require_relative '../models/scheduler/schedule'

class ScheduleGenerator
	# Recursively generate all possible schedule combinations for individual courses,
	# resulting in a list of schedules for each course (can be 2d array or map of course -> schedule array)

	# Every time a merge of schedules is done, first check if there are conflicts between existing schedule
	# and the course schedule that is being looked at. If not, merge the existing built schedule into the 
	# course schedule and store it in a new list. Get rid of old list of built schedules after it has been
	# iterated over completely; the new course schedule has been checked against each already built schedule.

	# Expecting array of course objects
	attr_reader :possible_schedules

	def initialize(courses)
		@possible_schedules = [Schedule.new]
		schedules = []

		if courses.any?
			courses.each { |course|
				course.get_possible_schedules.each { |new_sch|
					@possible_schedules.each { |poss_sch|
						if !poss_sch.conflicts_with? new_sch
							temp_sch = poss_sch.clone
							new_sch.merge(temp_sch)
							schedules << new_sch
						end
					}
				}

				@possible_schedules = schedules
			}
		end
	end
end