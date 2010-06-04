require 'spec_helper'

describe Enrollment do

  describe "#course_semester_in Named Scope" do
    before(:all) do
      @course_sems = [CourseSemester.make, CourseSemester.make]
      @enrolls_course_sem1 = (1..5).to_a.map { Enrollment.make :course_semester => @course_sems[0] }
      @enrolls_course_sem2 = (1..2).to_a.map { Enrollment.make :course_semester => @course_sems[1] }
    end
    after(:all) { DatabaseCleaner.clean }

    it 'should accept a CourseSemester as param' do
      Enrollment.course_semesters_in(@course_sems[0]).should == @enrolls_course_sem1
    end

    it 'should accept an Array of CourseSemesters' do
      Enrollment.course_semesters_in(@course_sems).should == Enrollment.all(:conditions => { :course_semester_id => @course_sems })
    end

    it 'should accept an Array of Integers(IDs)' do
      array = @course_sems.map(&:id)
      Enrollment.course_semesters_in(array).should == Enrollment.all(:conditions => { :course_semester_id => array })
    end
  end

  it '#semester_eql Named Scope should accept a semester as param' do
    course_sem = CourseSemester.make(:semester => 20101)
    enrolls_sem1 = (1..5).to_a.map { Enrollment.make :course_semester => course_sem }
    Enrollment.semester_eql(20101).should == enrolls_sem1
  end

  it '#student_eql Named Scope should accept a student_id as param' do
    student = Student.make
    enrolls_stud1 = (1..5).to_a.map { Enrollment.make :student => student }
    Enrollment.student_eql(student.id).should == enrolls_stud1
  end

  def create_enrollment_for_sort(student, hash)
    disc = Discipline.make(:code => hash[:discipline_code])
    disc.implementations.make(:school_semester => hash[:school_semester], :curriculum_id => student.curriculum.id)
    enrol = Enrollment.make(:student => student, :course_semester => CourseSemester.make(:semester => hash[:semester], :course => Course.make(:discipline => disc)))
    enrol
  end

  it "should sort by <=> -- | :semester => DESC | :school_semester => ASC | :discipline_code => ASC |" do
    student = Student.make
    @enrol1 = create_enrollment_for_sort(student, :semester => 20101, :school_semester => 1, :discipline_code => 12)
    @enrol2 = create_enrollment_for_sort(student, :semester => 20101, :school_semester => 1, :discipline_code => 13)
    @enrol3 = create_enrollment_for_sort(student, :semester => 20092, :school_semester => 1, :discipline_code => 10)
    @enrol4 = create_enrollment_for_sort(student, :semester => 20092, :school_semester => 2, :discipline_code => 3 )
    @enrol5 = create_enrollment_for_sort(student, :semester => 20092, :school_semester => 3, :discipline_code => 2 )
    [@enrol5,@enrol1,@enrol2,@enrol4,@enrol3].sort.should == [@enrol1, @enrol2, @enrol3, @enrol4, @enrol5]
  end

  context "proxy methods" do
    before( :all ) do
      @enroll = Enrollment.make
    end

    it "#discipline_name should return course_semester.course.discipline.name" do
      @enroll.discipline_name.should == @enroll.course_semester.course.discipline.name
    end

    it "#discipline_code should return course_semester.curse.discipline.code" do
      @enroll.discipline_code.should == @enroll.course_semester.course.discipline.code
    end

    it "#semester should return course_semester.semester" do
      @enroll.semester.should == @enroll.course_semester.semester
    end

    it "#confirmed? should return !confirmed_at.nil?" do
      @enroll.confirmed?.should == !@enroll.confirmed_at.nil?
    end

    it "#discipline should return course_semester.course.discipline" do
      @enroll.discipline.should == @enroll.course_semester.course.discipline
    end

    it "#course should return course_semester.course" do
     @enroll.course.should == @enroll.course_semester.course
    end

    it "confirm! should set confirmed_at to Time.now" do
      now = Time.zone.now
      Time.should_receive(:now).at_least(:once).and_return(now)
      @enroll.confirm!
      @enroll.reload
      @enroll.confirmed_at.to_i == now.to_i
    end

  end

  context "#status" do
    before( :all ) do
      @enroll = Enrollment.make
    end

    it "should be invalid when errors is not empty" do
      @enroll.errors.should_receive(:empty?).and_return(false)
      @enroll.status.should == "invalid"
    end

    context "when errors is empty" do
      before(:all) do
        @enroll.errors.should_receive(:empty?).and_return(true)
      end
      it "should be incomplete whem situation is nil" do
        @enroll.should_receive(:situation).and_return(nil)
        @enroll.status.should == 'incomplete'
      end

      context "when situation not nil" do
        it "should be valid when situation.active" do
          @enroll.situation = EnrollmentSituation.make(:active => true)
          @enroll.status.should == 'valid'
        end

        it "should be waiting when situation.active => false and description =~ /Aguardando/i" do
          @enroll.situation = EnrollmentSituation.make(:active => false, :description => 'Aguardando Confirmação')
          @enroll.status.should == 'waiting'
        end

        it "should be invalid when situation.active => false and description !~ /Aguardando/i" do
          @enroll.situation = EnrollmentSituation.make(:active => false, :description => 'Disciplina já concluída')
          @enroll.status.should == 'invalid'
        end
      end
    end
  end

  context "calling proposal_for_student" do
    it 'should return an empty array for a student without disciplines' do
      @student = Student.make_unsaved
      @student.curriculum.stub(:school_id).and_return(31)
      @student.curriculum.should_receive(:disciplines).and_return([])
      Enrollment.proposal_for_student(@student).should == []
    end

    #it 'should return an array of Enrollments with the disciplines from the curriculum' do
      #@student = Student.make
      #discipline = Discipline.make
      #discipline.courses.make(:course_school => CourseSchool.make(:school => @student.curriculum.school, :period => @student.curriculum.period)).course_semesters.make(:semester => (Time.now.year*10+((Time.now.month-1)/6+1)))
      #@student.curriculum.implementations.make(:discipline => discipline)
      #Enrollment.proposal_for_student(@student).map { |ep| ep.course_semester.course.discipline }.should == [discipline]
    #end
  end

  context "with custom validations" do
    it "should not let save when course_semester_id is not in proposal_for_student" do
      stud = Student.make
      course_sem = course_semester_for_curriculum(stud.curriculum, :semester => Time.now.year_semester)

      Enrollment.should_receive(:proposal_for_student).with(stud).and_return([])
      enroll2 = Enrollment.new(:validate_proposal => true, :student => stud, :course_semester => course_sem)

      enroll2.valid?

      enroll2.errors.should_not be_empty
    end
  end
end
