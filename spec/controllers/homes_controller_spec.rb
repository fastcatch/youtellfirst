require 'spec_helper'

describe HomesController do

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end

    it "should redirect to questions#index when user is logged in" do
      login_user_now
      get 'show'
      response.should redirect_to questions_path
    end
  end

end
