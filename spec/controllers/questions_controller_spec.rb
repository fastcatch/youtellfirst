require 'spec_helper'

describe QuestionsController do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Question. As you add validations to Question, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { text: "How far is the Moon?",
      answers_attributes: {
        '0' => { email: subject.current_user.email, text: 'some 400,000 kms' },
        '1' => { email: 'example@example.com' }
      }
  } }

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET index" do
    it "assigns all questions as @questions" do
      question = subject.current_user.questions.create! valid_attributes
      get :index, {}
      assigns(:questions).should eq([question])
    end
  end

  describe "GET show" do
    it "assigns the requested question as @question" do
      question = subject.current_user.questions.create! valid_attributes
      get :show, {:id => question.to_param}
      assigns(:question).should eq(question)
    end
  end

  describe "GET new" do
    it "assigns a new question as @question" do
      get :new, {}
      assigns(:question).should be_a_new(Question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Question" do
        expect {
          post :create, {:question => valid_attributes}
        }.to change(Question, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, {:question => valid_attributes}
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end

      it "redirects to the created question" do
        post :create, {:question => valid_attributes}
        response.should redirect_to(subject.current_user.questions.last)
      end

      it "displays the 'Request for Answer sent in email' message" do
        post :create, {:question => valid_attributes}
        flash[:notice].should match /Request for Answer sent in email/

        with_multiple_recepients = valid_attributes.dup
        with_multiple_recepients[:answers_attributes].merge!({'2' => { email: 'another.one@example.com' }})
        post :create, {:question => with_multiple_recepients }
        flash[:notice].should match /2 Requests for Answer sent in email/
      end

      it "sends an email to the invitee" do
        AnswerMailer.should_receive(:request_for_answer).and_return(double("mailer", :deliver => true))
        post :create, {:question => valid_attributes}
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        # Trigger the behavior that occurs when invalid params are submitted
        subject.current_user.questions.any_instance.stub(:save).and_return(false)
        post :create, {:question => valid_attributes}
        assigns(:question).should be_a_new(Question)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        subject.current_user.questions.any_instance.stub(:save).and_return(false)
        post :create, {:question => valid_attributes.update(text: "")}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested question" do
      question = subject.current_user.questions.create! valid_attributes
      expect {
        delete :destroy, {:id => question.to_param}
      }.to change(Question, :count).by(-1)
    end

    it "redirects to the questions list" do
      question = subject.current_user.questions.create! valid_attributes
      delete :destroy, {:id => question.to_param}
      response.should redirect_to(questions_url)
    end
  end

end
