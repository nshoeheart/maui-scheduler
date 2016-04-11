require_relative 'section'

#
# Class SectionGroup provides A container for a collection of associated sections within a Course. Courses with "mandatory sections" are organized such that there may be 6 discussion sections, 3 of which must be co-enrolled with a certain lecture section and the other 3 with a second lecture section. Courses with no defined mandatory sections just have a single section group.
#
# @author Nathan Schuchert <nathan@shoeheart.com>
#
class SectionGroup
	attr_reader(:mand_sec_num, # number of mandatory section
				:mand_group_ids, # array of maui section ids
				:sections) # group of associated sections

				#todo - need to add preferred sections, cross-references, etc. or store other data for special cases?

	#
	# Create a new instace of SectionGroup
	#
	# @param [String] mand_sec_num Section number of the mandatory section that all other sections within this group must be co-enrolled with. Only required for courses containing mandatory sections.
	# @param [Array<Integer>] mand_group_ids Array containing a list of MAUI IDs of the sections that make up this SectionGroup. Only required for courses containing mandatory sections.
	#
	def initialize(mand_sec_num=nil, mand_group_ids=nil)
		@mand_sec_num = mand_sec_num
		@mand_group_ids = mand_group_ids
		@sections = []
	end

	#
	# Determine if the provided Section object should be allowed to be inserted into this SectionGroup. Eligible sections have a maui_id that is contained within @mand_group_ids, or any section if @mand_group_ids is empty.
	#
	# @param [Section] section Section to determine eligibility for inclusion in this SectionGroup
	#
	# @return [Boolean] Whether or not the provided Section should be inserted into this SectionGroup
	#
	def is_eligible_section?(section)
		return (@mand_group_ids == nil || @mand_group_ids.length == 0 || @mand_group_ids.include?(section.maui_id))
	end

	#
	# Determine if the provided section already exists within this SectionGroup
	#
	# @param [Section] section Section object that will be checked to see if it's section number is already included in this SectionGroup
	#
	# @return [Boolean] Whether or not the provided Section's section number already exists within this SectionGroup
	#
	def has_section?(section)
		@sections.each { |s|
			if (s.section_num == section.section_num)
				return true
			end
		}

		return false
	end

	#
	# Add a Section object to this SectionGroup. It is recommended check if self.is_eligible_section?(section) is true prior to calling this method.
	#
	# @param [Section] section Section object to insert into this SectionGroup
	#
	# @return [SectionGroup] Updated instance of this SectionGroup
	#
	def add_section(section)
		@sections << section

		return self
	end

	#
	# Get the Section object whose section number is contained in @mand_sec_num, if it exists.
	#
	#
	# @return [Section] The mandatory Section object, if it exists. Return nil otherwise.
	#
	def get_mandatory_section
		if (@mand_sec_num == nil || @sections == nil || @sections.length==0)
			return nil
		else
			@sections.each { |section|
				if section.section_num == @mand_sec_num
					return section
				end
			}
		end

		return nil
	end

	#
	# Get the Section objects whose section numbers do not equal @mand_sec_num, if it is defined.
	#
	#
	# @return [Array<Section>] The non-mandatory Section objects, if they are defined. Returns nil otherwise.
	#
	def get_associated_sections
		associated_sections = []

		if (@mand_sec_num == nil || @sections == nil || @sections.length==0)
			return nil
		else
			@sections.each { |section|
				if section.section_num != @mand_sec_num
					associated_sections << section
				end
			}
		end

		return associated_sections
	end

	#
	# Generate and return all the possible Schedule combinations for this SectionGroup
	#
	#
	# @return [Array<Schedule>] All possible Schedule combinations for this SectionGroup
	#
	def get_possible_schedules
		schedules = []

		if @mand_sec_num == nil
			@sections.each { |sec|
				schedules << sec.schedule
			}
		else
			mand_sec = get_mandatory_section

			get_associated_sections.each { |asec|
				asec.schedule.merge(mand_sec.schedule)
				schedules << asec.schedule
			}
		end

		return schedules
	end
end