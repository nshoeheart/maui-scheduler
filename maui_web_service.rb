require_relative 'maui_web_service_util'

require_relative 'models/maui/course_subject'
require_relative 'models/maui/session'

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
	def self.get_courses(sessionCode, courseSubject)
		courses = get "/pub/registrar/course/dropdown/#{sessionCode}/#{courseSubject}"

		return courses
	end
end