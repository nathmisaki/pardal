require 'spec_helper'

describe CurrentUsersController do
  before(:each) do
    @user = User.make
    controller.should_receive(:authenticate_user!).and_return(true)
    controller.stub!(:current_user).and_return(@user)
  end

  context "PUT #update current_user with link_student" do
    it "should have flash[:notice] with 'Aluno atribuído com sucesso'" do
      @user.should_receive(:update_attributes).once.and_return(true)
      put :update
      flash[:notice].should == "Aluno atribuído com sucesso"
    end

    it "should redirect to show on success" do
      @user.should_receive(:update_attributes).once.and_return(true)
      put :update
      response.should redirect_to :action => :show
    end

    it "should render :link_student on error" do
      @user.should_receive(:update_attributes).once.and_return(false)
      put :update
      response.should render_template(:link_student)
    end
  end
end
