require 'spec_helper'

describe Answer do

  let(:question) { FactoryGirl.create(:question) }

  it { should belong_to(:question) }

  describe "protected updates" do
    it "allows updating an empty answer" do
      answer = question.answers.new(email: FactoryGirl.create(:user).email, text: '')
      answer.save.should be_true
      expect{ answer.update_attribute(:text, 'Good Question!') }.not_to raise_error(ActiveRecord::ReadOnlyRecord)
    end

    it "prevents updating everything else" do
      answer = question.answers.new(email: FactoryGirl.create(:user).email, text: 'First Take')
      answer.save.should be_true
      expect{ answer.update_attribute(:text, 'Changed My Mind') }.to raise_error(ActiveRecord::ReadOnlyRecord)
      expect{ answer.update_attribute(:email, FactoryGirl.create(:user).email) }.to raise_error(ActiveRecord::ReadOnlyRecord)
      expect{ answer.update_attribute(:uuid, SecureRandom.uuid) }.to raise_error(ActiveRecord::ReadOnlyRecord)
      expect{ answer.update_attribute(:question_id, FactoryGirl.create(:question).id) }.to raise_error(ActiveRecord::ReadOnlyRecord)
      expect{ answer.update_attribute(:user_id, FactoryGirl.create(:user).id) }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end

  it "generates a UUID for itself on save" do
    answer = question.answers.new(email: FactoryGirl.create(:user).email)
    answer.uuid.should be_nil
    answer.save
    answer.uuid.should be
  end

  it { should validate_presence_of :email }

  it "should validate the format of email" do
    answer = question.answers.new(email: FactoryGirl.create(:user).email)
    answer.should be_valid
    answer.email = 'noncompliant'
    answer.should_not be_valid
    answer.errors.messages[:email].should include("is invalid")
  end

  it "enables only one answer per email (user) per question" do
    user = FactoryGirl.create(:user)
    question.answers.create(email: user.email)
    second_answer = question.answers.create(email: user.email)
    second_answer.errors.messages[:email].should include("one answer is allowed per email address per question")
  end

  it { should_not allow_mass_assignment_of(:user_id) }

  it "fetches the user reference based on the email"  do
    user = FactoryGirl.create(:user)
    answer = question.answers.new(email: user.email)
    answer.save.should be_true
    answer.user.should == user
  end

end
