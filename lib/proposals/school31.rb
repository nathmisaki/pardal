module Proposals
  class School31 < Proposal
    def calculateEnrollments
      disciplines = student.curriculum.disciplines
      disciplines = disciplines_without_concluded(disciplines)


      courses = courses_from_curriculum(disciplines)


      enrollments = enrollments_from_courses(courses)
    end
  end
end
