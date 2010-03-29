class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject

  attr_accessor :link_student

  after_save :new_link_student

  private

  def validate
    if @link_student
      validate_link_student
    end
  end

  def validate_link_student
    student = Student.find_by_registration(@link_student[:registration])
    unless student.nil?
      errors.add(:link_student, "Identidade não confere") unless \
        student.identity.gsub(/\D/,'') == @link_student[:identity].gsub(/\D/,'')

      begin
        errors.add(:link_student, "Data de Emissão da Identidade não confere") unless \
          student.identity_emission_date == Date.new(*@link_student['identity_emission_date'].split('/').reverse.map(&:to_i))
      rescue ArgumentError
        errors.add(:link_student, "Data de Emissão da Identidade inválida")
      end
     
      errors.add(:link_student, "Iniciais do Nome da Mãe não conferem") unless \
        student.valid_mothers_name_initials?(@link_student[:mothers_name_initials])
    else
      errors.add(:link_student, "Aluno não encontrado")
    end


    if errors.empty?
      @link_student = student
    end
  end

  def new_link_student
    if @link_student
      self.has_role!(:owner_of, @link_student)
    end
  end

end
