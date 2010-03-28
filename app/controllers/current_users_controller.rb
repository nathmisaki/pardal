class CurrentUsersController < ApplicationController

  before_filter :find_current_user

  def show
  end

  def edit
  end

  def link_student
  end

  def update
    if @user.update_attributes(params[:user])
      unless params[:user][:link_student].nil?
        flash[:notice] = "Aluno atribuído com sucesso"
      else
        flash[:notice] = "Usuário atualizado com sucesso"
      end
      redirect_to :action => :show
    else
      unless params[:user][:link_student].nil?
        render :action => :link_student
      else
        render :action => :edit
      end
    end
  end

  private

  def find_current_user
    @user = current_user
  end
end
