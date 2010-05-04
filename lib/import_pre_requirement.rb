class ImportPreRequirement < ImportClass

  def initialize
    @old_table_class = LegacyPreRequirement
    @new_table_class = PreRequirement
    super
  end

  def parse
    @rows  = Array.new
    @curriculums ||= Curriculum.all

    @legacy_rows.each do |reg|
      curriculum = @curriculums.find { |c|
        c.school_id == reg[:CodigoDoCurso].to_i and
        c.period_id == reg[:CodigoDoTurno].to_i and
        c.structure_code == reg[:CodigoDaEstrutura].to_i
      }
      if curriculum
        implementations = curriculum.implementations.find(:all, :conditions => {
          :discipline_id => [reg[:CodigoDaDisciplina].to_i, reg[:CodigoDoPreRequisito].to_i]
        })
        hash = Hash.new
        hash[:implementation_id] = implementations.find{ |imp| imp.discipline_id == reg[:CodigoDaDisciplina].to_i }
        hash[:pre_requirement_id] = implementations.find{ |imp| imp.discipline_id == reg[:CodigoDoPreRequisito].to_i }
        if hash[:implementation_id] and hash[:pre_requirement_id]
          hash[:implementation_id] = hash[:implementation_id].id
          hash[:pre_requirement_id] = hash[:pre_requirement_id].id
          @rows << hash
        end
      end
    end
    @legacy_rows = nil
  end

end
