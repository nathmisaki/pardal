# encoding: utf-8
class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject

  has_many :attachments, :as => :attachable
  has_one :profile
  has_many :students

  attr_accessor :link_student

  after_save :new_link_student

  def self.find_for_authentication(condition)
    params = condition[:email].strip
    is_a_student_registration = /^[AFH]?[\d-]{7,10}$/xi
    if params =~ is_a_student_registration
      reg = Student.registration_with_initial_letter(params)
      student = Student.find_by_registration(reg)
      user = student.user
    end
    user ||= self.find_by_email(params)
    user
  end


  def objects_with_role(*args)
    role_name = args.shift
    options = args.extract_options!
    conditions = { :name => role_name.to_s }
    conditions.merge(:authorizable_type =>
                     options[:type].to_s.classify) unless options[:type].nil?
    ret = role_objects.all(:conditions => conditions)
    ret.map! { |ro| ro.authorizable } unless options[:role]
    ret
  end

  def attach_student!(student)
    student.user_id = self.id
    student.save
    self.has_role!(:owner, student)
    self.has_role!(:student, student)
  end

  ########################################################################
  ### L I N K _ S T U D E N T   M E T H O D S
  ########################################################################

  def link_student
    @link_student ||= {}
  end

  def link_student_registration
    link_student[:registration] if @link_student.is_a?(Hash)
  end

  def link_student_registration=(value)
    link_student[:registration] = value
  end

  def link_student_identity
    link_student[:identity] if @link_student.is_a?(Hash)
  end

  def link_student_identity=(value)
    link_student[:identity] = value
  end

  def link_student_identity_emission_date
    link_student[:identity_emission_date] if @link_student.is_a?(Hash)
  end

  def link_student_identity_emission_date=(value)
    link_student[:identity_emission_date] = value
  end

  def link_student_mothers_name_initials
    link_student[:mothers_name_initials] if @link_student.is_a?(Hash)
  end

  def link_student_mothers_name_initials=(value)
    link_student[:mothers_name_initials] = value
  end

  ########################################################################
  ### P R I V A T E   M E T H O D S
  ########################################################################

  private

  def validate
    unless link_student.blank?
      validate_link_student
    end
  end

  # Método chamado para validar entrada de novo Aluno no usuário
  #
  # Aqui são verificadas as variáveis que entram pelo formulário de
  # ligação de alunos: matrícula, identidade, data de emissão de
  # identidade, e iniciais do nome da mãe.
  #
  def validate_link_student

    # se a matrícula está vazia, é inválida!
    if @link_student[:registration].blank?
      errors.add(:link_student_registration, :invalid)
      return nil
    end

    student = Student.find_by_registration(@link_student[:registration])

    # se não encontrei o aluno
    if student.nil?
      errors.add(:link_student_registration, :not_find)
      return nil
    end

    # o aluno já tem dono
    unless student.user_id.nil?
      errors.add(:link_student_registration, :taken)
    end

    # identidade diferente
    errors.add(:link_student_identity, :not_match) unless \
      student.identity.gsub(/\D/,'') == @link_student[:identity].gsub(/\D/,'')

    begin
      date = @link_student[:identity_emission_date].split('/')
      date = date.reverse.map(&:to_i)

      # data de emissão diferente
      errors.add(:link_student_identity_emission_date, :not_match) unless \
        student.identity_emission_date == Date.new(*date)
    rescue ArgumentError
      # data de emissão inválida
      errors.add(:link_student_identity_emission_date, :invalid)
    end

    # iniciais do nome da mãe diferentes dos válidos
    errors.add(:link_student_mothers_name_initials, :not_match) unless \
      student.valid_mothers_name_initials?(
        @link_student[:mothers_name_initials])

    # se tudo está OK (sem erros) setar @link_student com o modelo student
    # encontrado para ser processado pelo método new_link_student
    if errors.empty?
      @link_student = student
    end
  end

  def new_link_student
    if @link_student.is_a?(Student)
      attach_student!(@link_student)
    end
  end

end
