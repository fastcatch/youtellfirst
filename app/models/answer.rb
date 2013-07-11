# answers are not editable!
class Answer < ActiveRecord::Base
  belongs_to :question
  # validates_presence_of :question_id

  # answer is blank as long as it's not filled in by the given user
  # usually the person who asks the question has an answer right away
  attr_accessible :text
  def self.pending
    where('(answers.text IS NULL OR answers.text = "")')
  end

  def pending?
    self.text.blank?
  end

  attr_accessible :email
  before_validation Proc.new{ |record| record.email.strip! if record.email.present? }
  validates_presence_of :email
  validates_uniqueness_of :email, scope: :question_id, allow_blank: true, message: 'one answer is allowed per email address per question'
  validates :email, format: { with: %r(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z), allow_nil: true, message: :invalid }

  # we either have a user or not: user is inferred from the email address
  belongs_to :user
  # user_id is not exposed for mass assignment (and should not really be set manually anyway)
  before_validation :identify_user_by_email

  # the UUID helps to prevent guessing the answer URL
  before_validation :generate_uuid

  # protect against most updates (well, kindof: some AR methods bypass callbacks)
  # N.B.: could override readonly? but the would also prevent destroying...
  before_update :protect_update
  after_update :distribute_all_answers_if_none_pending

private
  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def identify_user_by_email
    self.user = self.email.present? ? User.find_by_email(self.email) : nil
  end

  # allow update if and only if
  # => the only updated attribute is the text
  # AND
  # => text is changed from empty (for the first time)
  def protect_update
    unless self.changes.keys == ["text"] && self.changes["text"].first.blank?
      raise ActiveRecord::ReadOnlyRecord
    end
  end

  # TODO: factor out into an observer (but that's a pain to test)
  def distribute_all_answers_if_none_pending
    # only execute if text changed
    if self.changes.keys.include?("text") && self.changes["text"].first.blank?
      answers = self.question.answers
      if answers.pending.count == 0
        AnswerMailer.all_answers(self.question, answers.pluck(:email)).deliver
      end
    end
  end
end
