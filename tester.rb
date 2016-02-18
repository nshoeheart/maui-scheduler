require_relative 'maui_web_service'
require_relative 'models/maui/course_subject'
require_relative 'models/maui/session'

#------------------Helper Methods-------------------------
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

def select_courses(courses)
	puts "\nAdd courses one at a time from one of the following course numbers. When you are done adding courses for this subject, enter 'done'"
	courses.each{ |course| 
		print "#{course}, "
	}
	puts "\n"

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
#------------End Helper Methods-------------

#------------Start Main Script--------------
sessions = MauiWebService.get_sessions(2, 3)
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

course_subjects = MauiWebService.get_course_subjects
cs_hash = Hash.new
course_subjects.each { |cs|
	cs_hash[cs.naturalKey] = cs
}

puts "\nNow you will build a list of the courses you want to examine."

selected_courses = []
done_adding_courses = false

until done_adding_courses
	course_subject = select_course_subject(cs_hash)
	if course_subject == nil
		done_adding_courses = true
	else
		courses = MauiWebService.get_courses(session, course_subject)
		courses.sort!

		select_courses(courses).each { |course_num|
			selected_courses << "#{course_subject}:#{course_num}"
		}
	end
end

puts "\nCourses Selected:"
puts selected_courses

#todo get dates/times information

#------------END OF MAIN SCRIPT-------------------------

