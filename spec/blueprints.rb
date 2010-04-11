require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.object_name { Faker::Lorem.sentence.gsub(/[\.-]/, '') }
Sham.email{ Faker::Internet.email }
Sham.rg { rand(999999999).to_s.ljust(9, rand(9).to_s) }
Sham.date {
  year = rand(99)
  year = year >= 60 ? 1900+year : 2000+year
  month = rand(12)
  month += 1 if month == 0
  day = rand(28)
  day += 1 if day == 0
  begin
  Date.new(year, month, day)
  rescue ArgumentError
    raise ArgumentError, "#{year}-#{month}-#{day}"
  end
}

User.blueprint do
  email
  password "123456"
  password_confirmation "123456"
end

Student.blueprint do
  registration {
    number = "#{rand(99)}#{(rand(10) % 2) + 1}".rjust(3, '0') + rand(999).to_s.rjust(4, '0')
    number << Student.registration_verification_digit(number).to_s
    Student.registration_with_initial_letter(number)
  }
  name
  identity { Sham.rg }
  identity_emission_date Sham.date
  mothers_name Sham.name
  curriculum { Curriculum.make }
end

Discipline.blueprint do
  code { rand(9999) }
  name { Sham.object_name }
  department { Department.make }
  acronym { name.split(' ').map { |word| word[0].chr.upcase }.join }
  credit_hours { rand(180) }
end

Department.blueprint do
  name { Sham.object_name }
end

Curriculum.blueprint do
  school { School.make }
  period { Period.make }
  curriculum_type { [1,2].shuffle.shift }
  implementation_semester { (1970..2010).to_a.shuffle.shift }
end

School.blueprint do
  name { Sham.object_name }
  acronym { name.split(' ').map { |word| word[0].chr.upcase }.join }
  school_area { SchoolArea.make }
end

SchoolArea.blueprint do
  name { Sham.object_name }
end

Period.blueprint do
  name { ['MANHÃ', 'TARDE', 'NOITE', 'INTEGRAL'].shuffle.shift }
end
