require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name                   { Faker::Name.name }
Sham.sentence               { Faker::Lorem.sentence }
Sham.object_name            { Faker::Lorem.sentence.gsub(/[\.-]/, '') }
Sham.text                   { Faker::Lorem.paragraphs.join("\n") }
Sham.email                  { Faker::Internet.email }
Sham.rg                     { rand(999999999).to_s.ljust(9, rand(9).to_s) }
Sham.date(:unique => false) { Date.new((1980..2010).to_a.shuffle.first, rand(11)+1, rand(27)+1) }
Sham.registration { |index|
  }

User.blueprint do
  email
  password "123456"
  password_confirmation "123456"
end

Student.blueprint do
  registration {
    number = "#{(1980..2010).to_a.shuffle.first.to_s[2,2]}#{[1,2].shuffle.first}".rjust(3, '0') + rand(999).to_s.rjust(4, '0')
    number << Student.registration_verification_digit(number).to_s
    Student.registration_with_initial_letter(number)
  }
  name
  identity Sham.rg
  identity_emission_date Sham.date
  mothers_name Sham.name
  curriculum { Curriculum.make }
end

Discipline.blueprint do
  code { rand(9999) }
  name Sham.object_name
  department { Department.make }
  acronym { name.split(' ').map { |word| word[0].chr.upcase }.join }
  credit_hours { rand(180) }
end

Department.blueprint do
  name Sham.object_name
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
  name { ['MANHÃ', 'TARDE', 'NOITE', 'INTEGRAL'].shuffle.first }
end

Implementation.blueprint do
  curriculum { Curriculum.make }
  discipline { Discipline.make }
  discipline_type_id { (1..5).to_a.shuffle.first }
  school_semester { (1..6).to_a.shuffle.first }
end

CourseSchool.blueprint do
  period { Period.make }
  code { rand(300) }
  symbol { (65..90).to_a.map(&:chr).shuffle.shift }
end

Course.blueprint do
  discipline { Discipline.make }
  course_school { CourseSchool.make }
  grade_list_qty { (1..5).to_a.shuffle.shift }
  has_grade_list { [true,false].shuffle.shift }
  divide_class { [true,false].shuffle.shift }
end

Enrollment.blueprint do
  student { Student.make }
  course_semester { CourseSemester.make }
  situation { EnrollmentSituation.make }
end

EnrollmentSituation.blueprint do
  description { Sham.sentence }
  active { [true,false].shuffle.shift }
end

CourseSemester.blueprint do
  course { Course.make }
  semester { Time.now.year_semester }
end

CourseSchedule.blueprint do
  course_semester { CourseSemester.make }
  weekday { (2..7).to_a.shuffle.first }
  start_hour { ['7:30', '13:00', '19:00'].shuffle.first }
  end_hour { ['10:15', '15:45', '22:40'].shuffle.first }
end

Profile.blueprint do
  description Sham.text
end

PreRequirement.blueprint do
  implementation { Implmentation.make }
  pre_requirement { Implementation.make }
end

Help.blueprint do
end
