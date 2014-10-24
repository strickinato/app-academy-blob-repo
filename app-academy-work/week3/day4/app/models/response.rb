# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_can_not_respond_to_own_poll
  
  def question_id
    self.question.id
  end
  
  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )
  
  def sibling_responses
    self.question.responses.where.not(responses: { :id => self.id } )
  
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:user] << "has already answered question"
    end
  end
  
  def author_can_not_respond_to_own_poll
    if self.answer_choice.question.poll.author_id == self.user_id
      errors[:author] << "can not respond to his own poll!"
    end
  end
  
end
