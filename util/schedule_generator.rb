require_relative '../models/scheduler/schedule'

#
# Class ScheduleGenerator provides utility to generate all possible schedule combinations for a set of UIowa courses such that all courses are included in each schedule with no conflicting times.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class ScheduleGenerator

	attr_reader :possible_schedules

	#
	# Initalize a ScheduleGenerator that will use the provided Course objects to determine all possible valid schedule combinations
	#
	# @param [Array<Course>] courses a list of Course objects containing scheduling data on each of its sections that are offered as well as descriptive information about them.
	#
	def initialize(courses)
		@possible_schedules = [Schedule.new]
		schedules = []

		# Every time a merge of schedules is done, first check if there are conflicts between existing schedule
		# and the course schedule that is being looked at. If not, merge the existing built schedule into the
		# course schedule and store it in a new list. Get rid of old list of built schedules after it has been
		# iterated over completely; the new course schedule has been checked against each already built schedule.

		if courses.any?
			courses.each { |course|
				course.get_possible_schedules.each { |new_sch|
					@possible_schedules.each { |poss_sch|
						if !poss_sch.conflicts_with? new_sch
							temp_sch = poss_sch.clone
							temp_sch.merge(new_sch.clone)
							schedules << temp_sch
						end
					}
				}

				@possible_schedules = schedules
				schedules = []
			}
		end
	end
end