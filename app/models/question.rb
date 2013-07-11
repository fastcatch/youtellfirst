# questions are not editable!
class Question < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  attr_accessible :text
  validates_presence_of :text

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  attr_accessible :answers_attributes

  def pending?
    self.answers.pending.count > 0
  end
end
