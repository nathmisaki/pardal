# encoding: utf-8
class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject

  has_many :attachments, :as => :attachable
  has_one :profile

  attr_accessor :link_student

  after_save :new_link_student

  def self.find_for_authentication(condition)
    condition[:email].strip!
    is_email = %r{
      ^               # Start of string
      [[:alnum:]]     # First character
      [[:alnum:].+_]+ # Middle characters
      [[:alnum:]]     # Last character
      @               # Separating @ character
      [[:alnum:]]     # Domain name begin
      [[:alnum:].-]+  # Domain name middle
      [[:alnum:]]     # Domain name end
      $               # End of string
    }xi

    is_student_registration = %r/
      ^
      [AFH]? # First optional letter
      [\d-]{7,10}
      $
    /xi
    case condition[:email]
    when is_email
      self.find_by_email(condition[:email])
    when is_student_registration
      student = Student.find_by_registration(Student.registration_with_initial_letter(condition[:email]))
      student.user
    else
      self.find_by_email(condition[:email])
    end
  end

  def objects_with_role(*args)
    role_name = args.shift
    options = args.extract_options!
    conditions = { :name => role_name.to_s }
    conditions.merge(:authorizable_type => options[:type].to_s.classify) unless options[:type].nil?
    ret = role_objects.all(:conditions => conditions)
    ret.map! { |ro| ro.authorizable } unless options[:role]
    ret
  end

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

  def attach_student!(student)
    self.has_role!(:owner, student)
    self.has_role!(:student, student)
  end

  private

  def validate
    unless link_student.blank?
      validate_link_student
    end
  end

  def validate_link_student
    if @link_student[:registration].blank?
      errors.add(:link_student_registration, :invalid)
    else
      student = Student.find_by_registration(@link_student[:registration])
      if student.nil?
        errors.add(:link_student_registration, :not_find)
      else
        unless student.accepted_roles.all(:conditions => { :name => 'owner' }).empty?
          errors.add(:link_student_registration, :taken)
        else
          errors.add(:link_student_identity, :not_match) unless \
            student.identity.gsub(/\D/,'') == @link_student[:identity].gsub(/\D/,'')

          begin
            errors.add(:link_student_identity_emission_date, :not_match) unless \
              student.identity_emission_date == Date.new(*@link_student[:identity_emission_date].split('/').reverse.map(&:to_i))
          rescue ArgumentError
            errors.add(:link_student_identity_emission_date, :invalid)
          end

          errors.add(:link_student_mothers_name_initials, :not_match) unless \
            student.valid_mothers_name_initials?(@link_student[:mothers_name_initials])
        end
      end
    end

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
