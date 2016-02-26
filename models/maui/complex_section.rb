require_relative '../../lib/mixins/hash_constructor'

class ComplexSection
	attr_accessor(:courseId,
				:courseTitle,
				:prerequisite,
				:hasAdditionalRequirements,
				:isMultiSectionRegistration,
				:courseIdentityId,
				:academicUnitId,
				:subjectCourse,
				:legacyDeptCourse,
				:sectionId,
				:session,
				:beginDate,
				:endDate,
				:sectionNumber,
				:adminCollege,
				:generalCatalogUrl,
				:repeatability,
				:gradingInstructions,
				:corequisites,
				:genEds, # array
				:status,
				:plannerStatus,
				:sectionType,
				:sectionTypeSortOrder,
				:waitListPlan,
				:managementType,
				:syllabusUUID,
				:syllabusRequired,
				:hours,
				:minFeeHours,
				:maxEnroll,
				:maxUnreservedEnroll,
				:currentEnroll,
				:currentUnreservedEnroll,
				:unlimitedEnroll,
				:offcycle,
				:isIndependentStudySection,
				:adminRegistrationOnly,
				:prerequisiteEnforced,
				:deliveryModes,
				:deliveryTools,
				:globalRestrictions, # array
				:seatRestrictions, # array
				:timeAndLocations, # array of TimeAndLocation objects
				:additionalTimes, # array
				:screeningTimes, # array
				:examTimes, # array
				:instructors, # array of Instructor objects
				:courseTypes, # array
				:textBooks, # array of Textbook objects
				:courseFees,
				:adminHome,
				:legacyAdminHome,
				:generalCatalogText,
				:requirements,
				:recommendations,
				:sectionInfo,
				:registrationInfo,
				:mandatoryGroup, # array
				:mandatoryId,
				:mandatorySectionNumber,
				:coexistingSections, # array
				:legacyCoexistingSections, # array
				:crossReferences, # array
				:legacyCrossReferences, # array
				:preferredGroup, # array
				:preferredGroupSectionTypes, # array
				:lastDayToDropOrReduceHoursWithTuitionReduction,
				:lastDayToAddDropNoFee,
				:lastDayToAddWithoutDeanApproval,
				:lastDayToDropWithoutW,
				:lastDayToDropWithoutDeanApprovalUndergrad,
				:lastDayToDropWithoutDeanApprovalGrad)

	include HashConstructor

	class TimeAndLocation
		attr_accessor(:id,
					:sortOrder,
					:startTime,
					:endTime,
					:recurrence,
					:dates,
					:days,
					:sun,
					:mon,
					:tue,
					:wed,
					:thu,
					:fri,
					:sat,
					:room,
					:building,
					:arrangedLocation,
					:arrangedTime,
					:offsite,
					:fullRecurrence)

		include HashConstructor

		def to_str
			return ("id = #{id}\n" +
					"sortOrder = #{sortOrder}\n" +
					"startTime = #{startTime}\n" +
					"endTime = #{endTime}\n" +
					"recurrence = #{recurrence}\n" +
					"dates = #{dates}\n" +
					"days = #{days}\n" +
					"sun = #{sun}\n" +
					"mon = #{mon}\n" +
					"tue = #{tue}\n" +
					"wed = #{wed}\n" +
					"thu = #{thu}\n" +
					"fri = #{fri}\n" +
					"sat = #{sat}\n" +
					"room = #{room}\n" +
					"building = #{building}\n" +
					"arrangedLocation = #{arrangedLocation}\n" +
					"arrangedTime = #{arrangedTime}\n" +
					"offsite = #{offsite}\n" +
					"fullRecurrence = #{fullRecurrence}")
		end
	end
end