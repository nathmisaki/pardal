# encoding: utf-8
class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject

  has_many :attachments, :as => :attachable
  attr_accessor :link_student

  after_save :new_link_student

  def objects_with_role(role_name, type=nil)
    conditions = { :name => role_name.to_s }
    conditions.merge(:authorizable_type => type.to_s.classify) if type
    role_objects.all(:conditions => conditions)
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
      self.has_role!(:owner, @link_student)
      self.has_role!(:student, @link_student)
    end
  end

end
