class AnswerMailer < ActionMailer::Base

  def request_for_answer(answer)
    @answer = answer
    @question = @answer.question
    @asked_by = @question.user
    mail(to: @answer.email,  from: default_from, subject: "Answer this question!")
  end

  # send all answers to the email in the passed-in answer
  def all_answers(question, recipients)
    @question = question
    @asked_by = @question.user
    mail(to: recipients,  from: default_from, subject: "All answers to: #{@question.text}")
  end

private
  def default_from
    "notifications@" + Youtellfirst::Application.config.action_mailer.default_url_options[:host]
  end
end