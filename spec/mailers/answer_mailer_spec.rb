require 'spec_helper'

describe AnswerMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include ::Rails.application.routes.url_helpers

  describe "Request for Answer mail" do
    let(:answer) { FactoryGirl.create(:answer, text: '') }
    let(:question) { answer.question }
    let(:mail) { AnswerMailer.request_for_answer(answer) }

    it 'renders the subject' do
      mail.subject.should == 'Answer this question!'
    end

    it 'renders the receiver' do
      mail.to.should == [answer.email]
    end

    it 'renders the sender email' do
      mail.from.should == ["notifications@" + Youtellfirst::Application.config.action_mailer.default_url_options[:host]]
    end

    it 'contains who asked' do
      mail.body.encoded.should match(question.user.name)
    end

    it 'contains question' do
      mail.body.encoded.should match(question.text)
    end

    it 'contains link to answer' do
      mail.body.encoded.should match(edit_answer_path(answer.uuid))
    end
  end

  describe "Answers distribution mail" do
    let(:answer) { FactoryGirl.create(:answer) }
    let(:question) { answer.question }
    let(:mail) { AnswerMailer.all_answers(question, question.answers.pluck(:email)) }

    before(:each) do
      question.answers.pending.each{|a| a.update_column(:text, 'xyz')}
    end

    it 'renders the subject' do
      mail.subject.should match(question.text)
    end

    it 'renders the receiver' do
      mail.to.should == question.answers.collect(&:email)
    end

    it 'renders the sender email' do
      mail.from.should == ["notifications@" + Youtellfirst::Application.config.action_mailer.default_url_options[:host]]
    end

    it 'contains question' do
      mail.body.encoded.should match(question.text)
    end

    it 'contains answers' do
      question.answers.each do |a|
        mail.body.encoded.should match(a.text)
      end
    end

    it 'contains invitees' do
      question.answers.each do |a|
        name = a.user.try(:name) || a.email
        mail.body.encoded.should match(name)
      end
    end
  end
end