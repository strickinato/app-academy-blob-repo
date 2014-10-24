# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, presence: true
  
  belongs_to( 
    :poll, 
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )
  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    self.answer_choices
      .select("answer_choices.*, COUNT(responses.*)")
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .where("question_id = ?", 1)
      .group("answer_choices.id")
      .count("responses.id")
  end
  
end
# coalesce(COUNT(answer_choices.id), 0) AS Count
# <<-SQL
# SELECT
#   answer_choices.*, COUNT(responses.*)
# FROM
#   answer_choices
# LEFT OUTER JOIN
#   responses
# ON
#   (responses.answer_choice_id = answer_choices.id)
# WHERE
#   question_id = 1
# GROUP BY
#   answer_choices.id
#
# SQL

# <<-SQL
# SELECT
#   answer_choices.*, COUNT(responses.*)
# FROM
#   answer_choices
# LEFT OUTER JOIN
#   responses
# ON (answer_choices.id = responses.answer_choice_id)
# WHERE
#   answer_choices.question_id = 1
# GROUP BY
#   answer_choices.id
# SQL

#  First, write out the SQL that would return answer choice rows, augmented with a column that counts the number of responses to that answer choice.








