require 'spec_helper'

describe UsuariosController do

  #Delete these examples and add some real ones
  it "should use UsuariosController" do
    controller.should be_an_instance_of(UsuariosController)
  end


  describe "GET 'link_aluno'" do
    it "should be successful" do
      get 'link_aluno'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end
end
