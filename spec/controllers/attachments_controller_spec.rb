require 'spec_helper'

describe AttachmentsController do

  #Delete these examples and add some real ones
  it "should use AttachmentsController" do
    controller.should be_an_instance_of(AttachmentsController)
  end


  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end
end
