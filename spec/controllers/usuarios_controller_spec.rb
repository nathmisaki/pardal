require 'spec_helper'

describe UsersController do

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
