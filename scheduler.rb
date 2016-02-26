require_relative 'util/maui_web_service'
require_relative 'models/maui/course_subject'
require_relative 'models/maui/session'
require_relative 'models/maui/complex_section'
require_relative 'models/maui/instructor'

#------------------Helper Methods-------------------------

# Select a session to get courses for
def select_session(sessions)
	puts 'Select one of the following semesters by entering its code in parentheses:'
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

# Build a list of possible course subjects, return a hash that maps natural keys to their course subject objects
def build_subject_hash
	course_subjects = MauiWebService.get_course_subjects
	cs_hash = Hash.new

	course_subjects.each { |cs|
		cs_hash[cs.naturalKey] = cs
	}

	return cs_hash
end

# Select a subject to find courses in
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

# Select a course within a defined course subject
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

# Facilitate user input of selecting courses for scheduling, return an array of selected courses
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
def get_sections(session_code, selected_courses)
	sections = []
	# create array inside array for each group of sections
	selected_courses.each { |course_hash|
		sections << MauiWebService.get_complex_sections(session_code, course_hash[:subject], course_hash[:course])
	}

	return sections
end
#------------End Helper Methods-------------

#------------Start Main Script--------------

# Get a list of sessions and select the session for scheduling
sessions = MauiWebService.get_sessions(2, 3)
session_code = select_session(sessions)

# Select the courses to look at for scheduling
puts "\nNow you will build a list of the courses you want to examine."
selected_courses = select_courses(session_code)

# Print a list of selected courses
print "\nCourses Selected: "
selected_courses.each_with_index { |course_hash, i|
	print "#{course_hash[:subject]}:#{course_hash[:course]}"
	print ', ' unless i == selected_courses.length - 1
}
puts puts

puts 'Getting date and time info...'

sections = get_sections(session_code, select_courses)
puts sections.length

# todo parse sections in array to model that supports a scheduling algorithm

#------------END OF MAIN SCRIPT-------------------------