# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  question_id :integer
#  text        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  validates :question_id, presence: true
  
  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )
  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  
end
