class Student < ActiveRecord::Base
  acts_as_authorization_object
  has_many :attachment, :as => :attachable
  has_many :enrollments, :include => [:course_semester => :course]
  belongs_to :curriculum

  validates_uniqueness_of :registration

  def self.find_by_registration(registration_or_number)
    first :conditions => { :registration => registration_with_initial_letter(registration_or_number) }
  end

  def self.registration_with_initial_letter(registration_or_number)
    unless registration_or_number[0,1] =~ /[[:alpha:]]/
      letter = case registration_or_number[0,3].to_i
                 when (700..1000) then "A"
                 when (0...81) then "F"
                 when (81...700) then "H"
                 end
      registration_or_number = letter + registration_or_number
    end
    registration_or_number
  end

  # Receive registration number without the letter and returns
  # the verification digit
  def self.registration_verification_digit(registration_number)
    mult = (1..7).to_a.reverse
    sum = registration_number.chars.to_a.inject(0) do |s,char|
      s += char.to_i * mult.shift
    end

    digit = sum % 11
    digit = 11 - digit if digit > 1

    digit
  end

  def valid_mothers_name_initials?(initials)
    initials.strip!
    initials.upcase!
    mothers_name_initials.include?(initials)
  end

  def mothers_name_initials
    prepos_reg = /^e|d(o|a|e)s?$/i
    names = mothers_name.upcase
    [
      (names.split(/[\s']+/).map { |n| n[0,1] }.join ),
      (names.split(/[\s']+/).map { |n| n[0,1] unless n =~ prepos_reg }.compact.join),
      (names.split(/[\s]+/).map { |n| n[0,1] }.join),
      (names.split(/[\s]+/).map { |n| n[0,1] unless n=~ prepos_reg }.compact.join)
    ].sort
  end

  def discipline_concluded?(discipline_id)
    discipline_grades(discipline_id).map { |grade|
      ['A', 'B', 'D', 'E'].include?(grade)
    }.include?(true)
  end

  def discipline_grades(discipline_id)
    enrollments_from_discipline(discipline_id).map(&:grade)
  end

  def enrollments_from_discipline(discipline_id)
    enrollments.select { |e| e.course_semester.course.discipline_id == discipline_id }
  end

  def disciplines_with_pre_requirements_concluded(disciplines)
    disciplines.map do |discipline|
      pre_req_ary = curriculum.implementations.find_by_discipline_id(discipline.id).pre_requirements.map do |pre|
        discipline_concluded?(pre)
      end
      pre_reqs_ok = pre_req_ary.inject(true){|bool,pre| bool &&= pre}
      unless pre_reqs_ok
        disciplines.delete discipline
      end
    end
    disciplines
  end

end
