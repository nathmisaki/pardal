class CreateViewEnrollmentsForHistory < ActiveRecord::Migration
  def self.up
    sql = <<SQL
create or replace view enrollments_for_history as
select
  enrollments.*,
  implementations.school_semester,
  implementations.discipline_type_id,
  course_semesters.semester,
  disciplines.code AS discipline_code,
  disciplines.name AS discipline_name,
  disciplines.acronym AS discipline_acronym
from
  enrollments
join
  course_semesters
  on course_semesters.id = enrollments.course_semester_id
join
  disciplines
  on disciplines.id = (select courses.discipline_id from courses where courses.id = course_semesters.course_id)
left join
  implementations
  on implementations.discipline_id = disciplines.id and
     implementations.curriculum_id = (select students.curriculum_id from students where students.id = enrollments.student_id)
SQL
  execute(sql)
  end

  def self.down
    execute("drop view enrollments_for_history")
  end
end
