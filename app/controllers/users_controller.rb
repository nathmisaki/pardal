class UsersController < InheritedResources::Base
  actions :update
  before_filter :authenticate_user!

  def link_student
    @user = current_user
  end
  
  def update
    update! do |success, failure|
      success.html { redirect_to link_student_users_path }
      failure.html { render :action => :link_students }
    end
  end
end
