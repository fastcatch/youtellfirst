require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AnswersController do
#  login_user

  describe "GET index" do
    it "assigns all answers as @answers" do
      login_user_now
      answer = FactoryGirl.create(:answer, email: subject.current_user.email)
      get :index, {}
      assigns(:answers).should eq([answer])
    end
  end

  describe "GET show" do
    it "assigns the requested answer as @answer" do
      answer = FactoryGirl.create(:answer)
      get :show, {:id => answer.uuid}
      assigns(:answer).should eq(answer)
    end

    it "assigns the requested answer's question as @question" do
      answer = FactoryGirl.create(:answer)
      get :show, {:id => answer.uuid}
      assigns(:question).should eq(answer.question)
    end
  end

  describe "GET edit" do
    it "assigns the requested answer as @answer" do
      answer = FactoryGirl.create(:answer)
      get :edit, {:id => answer.uuid}
      assigns(:answer).should eq(answer)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested answer" do
        answer = FactoryGirl.create(:answer, text: '')
        # Assuming there are no other answers in the database, this
        # specifies that the Answer created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Answer.any_instance.should_receive(:update_attributes).with({ "text" => "something" })
        put :update, {:id => answer.uuid, :answer => { "text" => "something" }}
      end

      it "assigns the requested answer as @answer" do
        answer = FactoryGirl.create(:answer, text: '')
        put :update, {:id => answer.uuid, :answer => { "text" => "some test answer" }}
        assigns(:answer).should eq(answer)
      end

      it "redirects to answer" do
        answer = FactoryGirl.create(:answer, text: '')
        put :update, {:id => answer.uuid, :answer => { "text" => "some test answer" }}
        response.should redirect_to(answer_path(answer.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns the answer as @answer" do
        answer = FactoryGirl.create(:answer, text: 'It has a text')
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:update_attributes).and_return(false)
        put :update, {:id => answer.uuid, :answer => { "text" => "some test answer" }}
        assigns(:answer).should eq(answer)
      end

      it "re-renders the 'edit' template" do
        answer = FactoryGirl.create(:answer, text: 'It has a text')
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:update_attributes).and_return(false)
        put :update, {:id => answer.uuid, :answer => { "text" => "some test answer" }}
        response.should render_template("edit")
      end
    end
  end

end
