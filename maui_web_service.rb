require_relative 'maui_web_service_util'

require_relative 'models/maui/course_subject'
require_relative 'models/maui/session'

class MauiWebService < MauiWebServiceUtil
	# Returns an array of Session objects
	def self.getSessions(previous, future)
		sessionHash = get "/pub/registrar/sessions/bounded?previous=#{previous}&future=#{future}"
		
		sessions = []
		sessionHash.each{ |hash|
			session = Session.new(hash)
			sessions << session
		}

		return sessions
	end

	# Returns an array of CourseSubject objects
	def self.getCourseSubjects
		csHash = get "/pub/lookups/registrar/coursesubjects"
		
		courseSubjects = []
		csHash.each{ |hash| 
			courseSubject = CourseSubject.new(hash)
			courseSubjects << courseSubject
		}

		return courseSubjects
	end

	# Returns an array of course numbers
	def self.getCourses(sessionCode, courseSubject)
		courses = get "/pub/registrar/course/dropdown/#{sessionCode}/#{courseSubject}"

		return courses
	end
end