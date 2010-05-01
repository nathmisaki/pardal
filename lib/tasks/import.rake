namespace :import do

  desc "Import Departments from Legacy Departments"
  task :departments => :rename_tables do
    ImportDepartments.new.execute!
  end

  desc "Import Periods from Legacy Turnos"
  task :periods => :rename_tables do
    ImportPeriods.new.execute!
  end

  desc "Import School Areas from Legacy Areas"
  task :school_areas => :rename_tables do
    ImportSchoolAreas.new.execute!
  end

  desc "Import Disciplines from Legacy Disciplines"
  task :disciplines => :departments do
    ImportDisciplines.new.execute!
  end

  desc "Import Implementation from Legacy Implementations"
  task :implementations => [:curriculums, :periods, :disciplines] do
    ImportImplementations.new.execute!
  end

  desc "Import School from Legacy Cursos"
  task :schools => :school_areas do
    ImportSchools.new.execute!
  end

  desc "Import EnrollmentSituations from Legacy EnrollmentSituations"
  task :enrollment_situations => :environment do
    ImportEnrollmentSituations.new.execute!
  end

  desc "Import CourseSchool from Legacy Turmas"
  task :course_schools => [:schools, :periods] do
    ImportCourseSchools.new.execute!
  end


  desc "Import Curriculums from Legacy Curriculum"
  task :curriculums => [:create_views, :schools, :periods] do
    ImportCurriculums.new.execute!
  end

  desc "Import Student from Legacy Student"
  task :students => :curriculums do
    ImportStudents.new.execute!
  end

  desc "Import Courses from Legacy Courses"
  task :courses => [:course_schools, :disciplines] do
    ImportCourses.new.execute!
  end

  desc "Import all tables from Legacy"
  task :all => [:implementations, :students, :courses]

  desc "Rename tables before execute import tasks"
  task :rename_tables => :environment do
    rset = Academnew.connection.execute("show tables")
    old_tables_name = Array.new
    new_tables_name = Array.new
    rset.each{|e| old_tables_name << e.first}
    old_tables_name.each do |e|
      new_tables_name << e.dup
    end
    new_tables_name.each{|e| e.gsub!($&, "_#{$&.downcase}") while e =~ /[A-Z]/ ; e.sub!(/^_/,"")}
    while new_tables_name.first and old_tables_name.first
      new_table = new_tables_name.shift
      old_table = old_tables_name.shift
      if old_table != new_table
        query = "rename table #{old_table} to #{new_table}"
        Academnew.connection.execute(query)
      end
    end
  end

  desc "Create views to support import tasks"
  task :create_views => :rename_tables do
    Academnew.connection.execute("drop view if exists curriculum")
    Academnew.connection.execute(<<-SQL)
      create view curriculum as
      select * from compl_estruturas_curriculares
        natural join estruturas_curriculares;
    SQL
    Academnew.connection.execute("drop view if exists todos_alunos")
    Academnew.connection.execute(<<-SQL)
      create view todos_alunos as
      select *, 1 as Ativo
        from alunos
    SQL
  end

  desc "Cleanup Development database"
  task :clean_database => :environment do
    rset = ActiveRecord::Base.connection.execute("show tables")
    tables = Array.new
    rset.each {|reg| tables << reg}
    tables.flatten!
    tables.reject!{|table| table =~ /user/ ||
                           table == 'helps' ||
                           table == 'schema_migrations'}
    tables.each do |table|
      ActiveRecord::Base.connection.execute "TRUNCATE #{table}"
    end
  end

end
