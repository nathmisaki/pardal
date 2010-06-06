require 'spec_helper'

describe HomeController do
  describe "GET #index" do
    it "should redirect to /me" do
      get :index
      response.should redirect_to('/me')
    end
  end
end
