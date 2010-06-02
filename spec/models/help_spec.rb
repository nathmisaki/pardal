require 'spec_helper'

describe Help do
  before( :all ) do
    @help = Help.make(:page => "students-#-enrollments-new")
  end

  it "#find_page should return help with page name students-23-enrollments-new" do
    Help.find_page('students-23-enrollments-new').should == @help
  end
end
