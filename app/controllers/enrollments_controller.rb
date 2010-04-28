class EnrollmentsController < InheritedResources::Base
  belongs_to :student
  actions :index, :new, :create
  def new
    @student = Student.find(params[:student_id])
    @enrollments = Enrollment.proposal_for_student(@student)
    super
  end
end
