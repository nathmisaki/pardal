class EnrollmentsController < InheritedResources::Base
  belongs_to :student
  actions :index, :new, :create, :update, :destroy

  before_filter :authenticate_user!
  before_filter :load_student
  before_filter :load_proposal, :only => [:new, :create, :update]

  before_filter :allowance

  def index
    @enrollments = Enrollment.student_eql(@student.id).all :from => 'enrollments_for_history'
    @enrollments.sort!
    render :index, :layout => false if request.xhr?
  end

  def create
    create! do |success,failure|
      success.html { redirect_to :action => :new }
      failure.html { render :action => :new }
    end
  end

  def update
    update! do |success,failure|
      success.html { redirect_to :action => :new }
      failure.html { render :action => :new }
    end
  end

  def destroy
    destroy! do |success,failure|
      success.html { redirect_to :action => :new }
      failure.html { render :action => :new }
    end
  end

  private

  def load_student
    @student ||= Student.find(params[:student_id])
  end

  def load_proposal
    @student ||= load_student
    @enrollments = Enrollment.proposal_for_student(@student)
    @enrollment = @enrollments.find { |e| e.course_semester_id == params[:enrollment][:course_semester_id].to_i } if params[:enrollment]
  end

  def allowance
    unless current_user.has_role?(:student, @student)
      flash[:error] = "Você não tem acesso a essa parte do sistema"
      redirect_to current_user_path
    end
  end

end
