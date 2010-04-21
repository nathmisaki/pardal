require File.join(File.dirname(__FILE__), 'rake_helper')

namespace :import do

  desc "Import School Areas from Legacy Areas"
  task :school_areas => :environment do
    ImportSchoolAreas.new.execute!
  end

  desc "Import School from Legacy Cursos"
  task :schools => :school_areas do
    ImportSchools.new.execute!
  end

  desc "Import Periods from Legacy Turnos"
  task :periods => :environment do
    ImportPeriods.new.execute!
  end

  desc "Import Curriculums from Legacy Curriculum"
  task :curriculum => [:schools, :periods] do
    ImportCurriculums.new.execute!
  end

  desc "Import all tables from Legacy"
  task :all => [:curriculum]

end
