require_relative 'maui_web_service'
require_relative 'models/maui/course_subject'
require_relative 'models/maui/session'

sessions = MauiWebService.getSessions(2, 3)
puts 'Select one of the following semesters by entering its code in parentheses:'
sessions.each { |s| 
	puts "\t#{s.shortDescription} (#{s.legacyCode})"
}

session = nil
session_selected = false

until session_selected
	print 'Session code: '
	session = gets.chomp

	sessions.each { |s|
		if (s.legacyCode == session)
			session_selected = true
			puts "Selected session: #{s.shortDescription} (#{session})"
		end
	}

	puts 'Invalid session code' unless session_selected
end

courseSubjects = MauiWebService.getCourseSubjects
csHash = Hash.new
courseSubjects.each { |cs|
	csHash[cs.naturalKey] = cs
}

puts "\nNow you will build a list of the courses you want to examine."

selectedCourses = []
done_adding_courses = false

until done_adding_courses
	courseSubject = selectCourseSubject(csHash)
	if (courseSubject == nil) break

	courses = MauiWebService.getCourses(session, courseSubject)
	courses.sort!

	puts "\nAdd courses one at a time from one of the following course numbers. When you are done adding courses for this subject, enter 'done'"
	puts
	courses.each{ |course| 
		print "#{course}, "
	}
	puts

	courseSelection = nil
	until courseSelection == 'done'
		print 'Course number: '
		courseSelection = gets.chomp

		if (not ((courses.include?(courseSelection)) or courseSelection.downcase == 'done'))
			puts 'Invalid course number'
		end
	end
end

def selectCourseSubject(csHash)
	courseSubject = nil
	done_selecting_cs = false

	puts "Enter a subject's code (such as CBE, ENGR, or CS). When you are finished adding all courses, enter 'finished'"
	until done_selecting_cs
		print 'Subject code: '
		courseSubject = gets.chomp.upcase

		if courseSubject == 'FINISHED'
			return nil #indicates done adding courses
		elsif csHash.has_key?(courseSubject)
			done_selecting_cs = true
			puts "Selected subject: #{csHash[courseSubject].description} (#{courseSubject})"
		end

		puts 'Invalid subject' unless done_selecting_cs
	end

	return courseSubject
end

