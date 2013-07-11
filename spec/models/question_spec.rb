require 'spec_helper'

describe Question do

  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }

  it { should validate_presence_of(:text) }

  it { should have_many(:answers) }

  describe 'pending?' do
    it "should be pending with pending answers" do
      question = FactoryGirl.create(:question)
      question.pending?.should be_true
    end

    it "should not be pending if it has no pending answers" do
      question = FactoryGirl.create(:question)
      question.answers.pending.each {|a| a.update_attribute(:text, 'xyz')}
      question.pending?.should be_false
    end
  end
end
