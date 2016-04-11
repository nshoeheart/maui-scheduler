require_relative 'maui_web_service_util'

require_relative '../models/maui/course_subject'
require_relative '../models/maui/session'
require_relative '../models/maui/complex_section'
require_relative '../models/maui/instructor'

#
# Class MauiWebService provides methods to fetch data from UIowa's MAUI web services and construct and return objects from the JSON that is received
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class MauiWebService < MauiWebServiceUtil

	#
	# Get a list of Session objects from UIowa's MAUI web services
	#
	# @param [Integer] previous Number of semesters prior to the current semester to fetch
	# @param [Integer] future Number of semesters following the current semester to fetch
	#
	# @return [Array<Session>] List of Session objects
	#
	def self.get_sessions(previous, future)
		session_hash = get "/pub/registrar/sessions/bounded?previous=#{previous}&future=#{future}"

		sessions = []
		session_hash.each{ |hash|
			session = Session.new(hash)
			sessions << session
		}

		return sessions
	end

	#
	# Get a list of CourseSubject objects from UIowa's MAUI web services
	#
	#
	# @return [Array<CourseSubject>] List of CourseSubject objects
	#
	def self.get_course_subjects
		cs_hash = get "/pub/lookups/registrar/coursesubjects"

		course_subjects = []
		cs_hash.each{ |hash|
			course_subject = CourseSubject.new(hash)
			course_subjects << course_subject
		}

		return course_subjects
	end

	#
	# Get a list of course numbers from UIowa's MAUI web services for the provided session and subject
	#
	# @param [String] session_code Session code in legacy format corresponding to a particular session, e.g. 20158, 20133
	# @param [String] subject Subject code such as CBE, CHEM, CS, ECON, etc.
	#
	# @return [Array<Integer>] List of course numbers
	#
	def self.get_courses(session_code, subject)
		courses = get "/pub/registrar/course/dropdown/#{session_code}/#{subject}"

		return courses
	end

	#
	# Get a list of ComplexSection objects from UIowa's MAUI web services by session code, subject, and course numbers
	#
	# @param [String] session_code Session code in legacy format corresponding to a particular session, e.g. 20158, 20133
	# @param [String] subject Subject code such as CBE, CHEM, CS, ECON, etc.
	# @param [Integer] course_num Course number to find sections under
	#
	# @return [Array<ComplexSection>] List of ComplexSection objects
	#
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