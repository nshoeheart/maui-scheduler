require_relative 'section'

class SectionGroup
	attr_reader(:mand_sec_num, # number of mandatory section
				:mand_group_ids, # array of maui section ids
				:sections) # group of associated sections
				
				#todo - need to add preferred sections, cross-references, etc. or store other data?

	def initialize(mand_sec_num=nil, mand_group_ids=nil)
		@mand_sec_num = mand_sec_num
		@mand_group_ids = mand_group_ids
		@sections = []
	end

	def is_eligible_section?(section)
		return (@mand_group_ids == nil || @mand_group_ids.length == 0 || @mand_group_ids.include?(section.maui_id))
	end

	def has_section?(section)
		@sections.each { |s|
			if (s.section_num == section.section_num)
				return true
			end
		}

		return false
	end

	# Recommended to call is_elgible_section? prior to adding section to group
	def add_section(section)
		@sections << section
	end

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