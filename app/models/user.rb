class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :link_student

  private

  def validate
    if @link_student
      validate_link_student
    end
  end

  def validate_link_student
    student = Student.find_by_registration(@link_student[:registration])
    unless student.nil?
      errors.add(:link_student, "Identidade não confere")                                          unless \
        student.identity.gsub(/\D/,'') == @link_student[:identity].gsub(/\D/,'')

      @link_student['identity_emission_date(1i)'].inspect
      errors.add(:link_student, "Data de Emissão da Identidade não confere")                       unless \
        student.identity_emission_date == Date.new(@link_student['identity_emission_date(1i)'].to_i,
                                                   @link_student['identity_emission_date(2i)'].to_i,
                                                   @link_student['identity_emission_date(3i)'].to_i)

      errors.add(:link_student, "Iniciais do Nome da Mãe não conferem")                            unless \
        student.valid_mothers_name_initials?(@link_student[:mothers_name_initials])
    else
      errors.add(:link_student, "Aluno não encontrado")
    end
  end

end
