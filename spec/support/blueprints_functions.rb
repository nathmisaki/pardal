def enrollment_with_implementation(options=nil)
  enroll_attr = {}
  enroll_attr[:student] = options[:student] if options[:student]
  enroll_attr[:grade] = options[:grade] if options[:grade]
  enroll_attr[:course_semester] = options[:course_semester] if options[:course_semester]
  enroll_attr[:situation] = options[:situation] if options[:situation]
  enrollment = Enrollment.make(enroll_attr) do |enroll|
    enroll.course_semester.semester = options[:semester]
    imp_attr = {:curriculum => enroll.student.curriculum}
    imp_attr[:school_semester] = options[:school_semester] if options[:school_semester]
    enroll.discipline.implementations.make(imp_attr)
  end
  enrollment
end

def course_semester_for_curriculum(curriculum, options=nil)
  course_school_attr = {:school_id => curriculum.school_id, :period_id => curriculum.period_id}
  course_school_attr[:code] = options[:course_school_code] if options[:course_school_code]

  coursem_attr = {}
  coursem_attr[:semester] = options[:semester] if options[:semester]
  coursem_attr[:course] = options[:course] if options[:course]

  disc_attr = {}
  disc_attr[:name] = options[:discipline_name] if options[:discipline_name]
  if options[:discipline_code]
    disc_attr[:code] = options[:discipline_code]
    disc_attr[:id] = options[:discipline_code]
  end

  disc = curriculum.disciplines.make(disc_attr)
  course = disc.courses.make(:course_school => CourseSchool.make(course_school_attr))

  course.course_semesters.make(coursem_attr)
end
