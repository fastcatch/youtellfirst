require "spec_helper"

describe AnswersController do
  before do
    @uuid = FactoryGirl.create(:answer).uuid
  end

  describe "routing" do

    #it "routes to #index" do
      # it is an authenticated route and as such cannot be tested here
      #  get("/answers").should be_routable
    #end

    it "routes to #new" do
      get("/answers/new").should_not be_routable
    end

    it "routes to #show" do
      get("/answers/#{@uuid}").should be_routable
    end

    it "routes to #edit" do
      get("/answers/#{@uuid}/edit").should route_to("answers#edit", :id => @uuid)
    end

    it "routes to #create" do
      post("/answers").should_not be_routable
    end

    it "routes to #update" do
      put("/answers/#{@uuid}").should route_to("answers#update", :id => @uuid)
    end

    it "routes to #destroy" do
      delete("/answers/#{@uuid}").should_not be_routable
    end

  end
end
