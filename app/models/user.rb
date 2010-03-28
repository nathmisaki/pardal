class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :link_student

  def link_student=(student_attributes)
    student = Student.find_by_registration(student_attributes[:registration])
    unless student
      errors.add(:link_student, "Identidade não confere")                                          unless \
        student.identity.gsub(/\D/,'') == student_attributes[:identity].gsub(/\D/,'')

      errors.add(:link_student, "Data de Emissão da Identidade não confere")                       unless \
        student.identity_emission_date == Date.strptime(student_attributes[:identity_emission_date])

      errors.add(:link_student, "Iniciais do Nome da Mãe não conferem")                            unless \
        student.valid_mothers_name_initials?(student_attributes[:mothers_name_initials])
    else
      errors.add(:link_student, "Aluno não encontrado")
    end
  end

end
