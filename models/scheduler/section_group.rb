require_relative 'section'

class SectionGroup
	attr_reader(:sections,
				:mandatory_group, #array of section numbers
				:mandatory_section_number,
				:mandatory_id)

				#todo - need to add preferred sections, cross-references, etc?

	
end