class EnrollmentsController < InheritedResources::Base
  belongs_to :student
  actions :index, :new, :create

  before_filter :load_student


  def new
    @enrollments = Enrollment.proposal_for_student(@student)
    super
  end

  def create
    @enrollments = Enrollment.proposal_for_student(@student)
    @enrollment = @enrollments.find { |e| e.course_semester_id == params[:enrollment][:course_semester_id].to_i }
    create! do |success,failure|
      success.html { redirect_to :action => :new }
      failure.html { render :action => :new }
    end
  end


  private

  def load_student
    @student = Student.find(params[:student_id])
  end
end
