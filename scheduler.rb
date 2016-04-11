require_relative 'models/maui/course_subject'
require_relative 'models/maui/session'
require_relative 'models/maui/complex_section'
require_relative 'models/maui/instructor'
require_relative 'models/scheduler/schedule'

require_relative 'util/maui_web_service'
require_relative 'util/section_builder'
require_relative 'util/schedule_generator'

# Main script used to run maui-scheduler application

#------------------Helper Methods-------------------------

#
# Script to select a session to get courses for
#
# @param [Array<Session>] sessions List of Session objects retrieved from MAUI
#
# @return [Session] The Session object that was selected
#
def select_session(sessions)
	puts 'Select one of the following semesters by entering its code (the one in parentheses):'
	sessions.each { |s|
		puts "\t#{s.shortDescription} (#{s.legacyCode})"
	}

	session = nil
	session_selected = false

	until session_selected
		print 'Session Code: '
		session = gets.chomp

		sessions.each { |s|
			if (s.legacyCode == session)
				session_selected = true
				puts "Selected Session: #{s.shortDescription} (#{session})"
			end
		}

		puts 'Invalid Session Code' unless session_selected
	end

	return session
end

#
# Build a list of possible course subjects and populate a hash mapping subject natural keys to their CourseSubject objects
#
#
# @return [Hash{String => CourseSubject}] Hash of CourseSubjects keyed by their natural keys (e.g. CBE, ECON, RHET, etc.)
#
def build_subject_hash
	course_subjects = MauiWebService.get_course_subjects
	cs_hash = Hash.new

	course_subjects.each { |cs|
		cs_hash[cs.naturalKey] = cs
	}

	return cs_hash
end

#
# Select a subject (such as CBE, ENGR, CS, etc.) for which to retrieve a list of course numbers for the given semester
#
# @param [Hash{String => CourseSubject}] cs_hash Hash of CourseSubjects keyed by their natural keys (e.g. CBE, ECON, RHET, etc.)
#
# @return [CourseSubject] The CourseSubject object for which to retrieve a list of course numbers from MAUI
#
def select_course_subject(cs_hash)
	course_subject = nil
	done_selecting_cs = false

	puts "\nEnter a subject's code (such as CBE, ENGR, or CS). When you are finished adding all courses, enter 'done'"
	until done_selecting_cs
		print 'Subject Code: '
		course_subject = gets.chomp.upcase

		if course_subject == 'DONE'
			return nil #indicates done adding courses
		elsif cs_hash.has_key?(course_subject)
			done_selecting_cs = true
			puts "Selected Subject: #{cs_hash[course_subject].description} (#{course_subject})"
		end

		puts 'Invalid Subject' unless done_selecting_cs
	end

	return course_subject
end

#
# Repeating script to select multiple course numbers for which to retrieve scheduling information
#
# @param [Array<Integer>] courses a list of course numbers within a given course subject that represent valid courses within that subject
#
# @return [Array<Integer>] A selected subset of the provided course numbers for which to get scheduling information from MAUI
#
def select_courses_in_subject(courses)
	puts "\nAdd courses one at a time from one of the following course numbers. When you are done adding courses for this subject, enter 'done'"
	courses.each_with_index { |course, i|
		print "#{course}"
		print ', ' unless i == courses.length - 1
	}
	puts puts

	selected_courses = []
	course_selection = nil
	done_selecting_courses = false

	until done_selecting_courses
		print 'Course Number: '
		course_selection = gets.chomp

		if course_selection.downcase == 'done'
			done_selecting_courses = true
		elsif courses.include?(course_selection)
			selected_courses << course_selection
			puts "Added course with number: #{course_selection}"
		else
			puts 'Invalid Course Number'
		end
	end

	return selected_courses
end

#
# Script to facilitate user input of selecting courses to be scheduled
#
# @param [String] session_code Legacy session code such as '20133' representing a session in MAUI
#
# @return [Array<Hash{:subject => CourseSubject, :course => Integer}>] List of hashes to organize each selected course's data into a CourseSubject object keyed on :subject and a course number keyed on :course
#
def select_courses(session_code)
	selected_courses = []
	done_adding_courses = false
	cs_hash = build_subject_hash

	until done_adding_courses
		course_subject = select_course_subject(cs_hash)
		if course_subject == nil
			done_adding_courses = true
		else
			courses = MauiWebService.get_courses(session_code, course_subject)
			courses.sort!

			select_courses_in_subject(courses).each { |course_num|
				selected_courses << {subject: course_subject, course: course_num}
			}
		end
	end

	return selected_courses
end

# Retrieve a list of sections for each selected course. Each course corresponds to an index in the array,
# which contains a sub-array of sections
# TODO - should this be made into a hash with course=key and sections[]=value?

#
# Retrieve a list of sections from MAUI for each selected course
#
# @param [String] session_code Legacy session code such as '20133' representing a session in MAUI
# @param [Array<Hash{:subject => CourseSubject, :course => Integer}>] selected_courses List of hashes to organize each selected course's data into a CourseSubject object keyed on :subject and a course number keyed on :course
#
# @return [Array<Array<ComplexSection>>] Array of Arrays of ComplexSection objects obtained from MAUI for each selected course that contain all necessary section information for scheduling
#
def get_courses(session_code, selected_courses)
	courses = []
	# create array inside array for each group of sections
	selected_courses.each { |course_hash|
		courses << MauiWebService.get_complex_sections(session_code, course_hash[:subject], course_hash[:course])
	}

	return courses
end

#
# Print the available options for enrollment in each of the provided courses
#
# @param [Array<Course>] courses Array of Course objects for which to print scheduling options
#
def print_courses(courses)
	courses.each { |course|
		puts "\n"
		puts "#{course.subject}:#{course.course_num} - #{course.course_title}"

		course.section_groups.each { |group|
			puts "\tSection Group:"

			group.sections.each { |section|
				puts "\t\t#{section.full_section_num} - #{section.section_type}"

				section.schedule.days.each { |day_key, day|
					print "\t\t\t#{day.short_name} -> "

					day.events.each_with_index { |event, i|
						print event.time_and_loc
						if (i == day.events.length - 1)
							print "\n"
						else
							print ', '
						end
					}
				}
			}
		}
	}

	return nil
end

#
# Print the list of possible schedule combinations that were computed
#
# @param [Array<Schedule>] possible_schedules List of all possible schedule combinations containing all selected courses
#
def print_schedules(possible_schedules)
	if possible_schedules.any?
		possible_schedules.each_with_index { |sch, i|
			puts "POSSIBLE SCHEDULE \##{i + 1}:\n#{"-" * 23}"
			sch.print
			puts "\n" unless i == possible_schedules.length - 1
		}
	else
		puts "No possbible schedule combinations found for this set of courses."
	end

	return nil
end

#------------End Helper Methods-------------

#------------Start Main Script--------------

# Get a list of sessions and select the session for scheduling
sessions = MauiWebService.get_sessions(2, 3)
session_code = select_session(sessions)

# Select the courses to look at for scheduling
puts "\nNow you will build a list of the courses you want to schedule."
selected_courses = select_courses(session_code)

# Print a list of selected courses
print "\nCourses Selected: "
selected_courses.each_with_index { |course_hash, i|
	print "#{course_hash[:subject]}:#{course_hash[:course]}"
	print ', ' unless i == selected_courses.length - 1
}
puts puts

# Get course information including dates and times offered from MAUI that will be used for creating schedules
puts 'Getting date and time info...'
maui_courses = get_courses(session_code, selected_courses)

# Convert the data retrieved from MAUI into the data format that will be used for examining possible schedule options
section_builder = SectionBuilder.new(maui_courses)
courses = section_builder.courses
print_courses(courses)

puts puts

# Generate a list of all possible schedules that allow enrollment in all selected courses without a timing conflict, and print them
schedule_generator = ScheduleGenerator.new(courses)
print_schedules(schedule_generator.possible_schedules)


#------------END OF MAIN SCRIPT-------------------------