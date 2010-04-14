require File.join(File.dirname(__FILE__), 'rake_helper')

namespace :import do

  desc "Import School Areas from Legacy Areas"
  task :school_areas => :environment do
    ImportSchoolAreas.new.execute!
  end


end
