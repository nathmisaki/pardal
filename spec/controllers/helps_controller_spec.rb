require 'spec_helper'

describe HelpsController do
  describe "GET show" do
    it "should render template :show" do
      help = Help.make
      get :show, :id => help.to_param
      response.should render_template('show')
      response.layout.should_not be_nil
    end

    it "should render template :show, without layout" do
      help = Help.make
      xhr :get, :show, :id => help.to_param
      response.should render_template('show')
      response.layout.should be_nil
    end
  end
end
