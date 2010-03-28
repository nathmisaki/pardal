class Student < ActiveRecord::Base

  validates_uniqueness_of :registration

  def self.find_by_registration(registration_or_number)
    first :conditions => { :registration => registration_with_initial_letter(registration_or_number) }
  end

  private

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

end
