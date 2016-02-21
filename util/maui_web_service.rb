require_relative 'maui_web_service_util'

require_relative '../models/maui/course_subject'
require_relative '../models/maui/session'
require_relative '../models/maui/complex_section'
require_relative '../models/maui/instructor'

class MauiWebService < MauiWebServiceUtil
	# Returns an array of Session objects
	def self.get_sessions(previous, future)
		session_hash = get "/pub/registrar/sessions/bounded?previous=#{previous}&future=#{future}"
		
		sessions = []
		session_hash.each{ |hash|
			session = Session.new(hash)
			sessions << session
		}

		return sessions
	end

	# Returns an array of CourseSubject objects
	def self.get_course_subjects
		cs_hash = get "/pub/lookups/registrar/coursesubjects"
		
		course_subjects = []
		cs_hash.each{ |hash| 
			course_subject = CourseSubject.new(hash)
			course_subjects << course_subject
		}

		return course_subjects
	end

	# Returns an array of course numbers
	def self.get_courses(session_code, subject)
		courses = get "/pub/registrar/course/dropdown/#{session_code}/#{subject}"

		return courses
	end

	def self.get_complex_sections(session_code, subject, course_num)
		sections_hash = get "/pub/registrar/sections/#{session_code}/#{subject}/#{course_num}?complex=true"

		sections = []

		sections_hash.each{ |section_hash| 
			section = ComplexSection.new(section_hash)
			
			timeAndLocations = []
			section.timeAndLocations.each{ |tal_hash| 
				timeAndLocations << ComplexSection::TimeAndLocation.new(tal_hash)
			}
			section.timeAndLocations = timeAndLocations

			instructors = []
			section.instructors.each { |instructor_hash|  
				instructors << Instructor.new(instructor_hash)
			}
			section.instructors = instructors

			sections << section
		}

		return sections
	end
end