# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true
  
  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
  :responses,
  class_name: "Response",
  foreign_key: :user_id,
  primary_key: :id
  )
  
  def completed_polls
    query = <<-SQL
    SELECT polls.*
    FROM
      (SELECT polls.id AS pollsID, COUNT(questions.id) AS TotalQuestions
      FROM polls JOIN questions 
      ON polls.id = questions.poll_id 
      GROUP BY polls.id) AS question_poll
    JOIN
      (SELECT polls.id AS pollsID, COUNT(responses.id) AS TotalResponses
      FROM
      polls
      JOIN
      questions 
      ON 
      polls.id = questions.poll_id
      JOIN
      answer_choices
      ON
      questions.id = answer_choices.question_id
      JOIN
      responses
      ON
      answer_choices.id = responses.answer_choice_id
      WHERE responses.user_id = #{self.id}
      GROUP BY polls.id) AS response_poll
    ON
      question_poll.pollsID = response_poll.pollsID
    JOIN
      polls
      ON
      question_poll.pollsID = polls.id
    WHERE TotalQuestions = TotalResponses
    SQL
    
    Poll.find_by_sql(query)
  end
  
  def incomplete_polls
    query = <<-SQL
    SELECT polls.*
    FROM
      (SELECT polls.id AS pollsID, COUNT(questions.id) AS TotalQuestions
      FROM polls JOIN questions 
      ON polls.id = questions.poll_id 
      GROUP BY polls.id) AS question_poll
    JOIN
      (SELECT polls.id AS pollsID, COUNT(responses.id) AS TotalResponses
      FROM
      polls
      JOIN
      questions 
      ON 
      polls.id = questions.poll_id
      JOIN
      answer_choices
      ON
      questions.id = answer_choices.question_id
      JOIN
      responses
      ON
      answer_choices.id = responses.answer_choice_id
      WHERE responses.user_id = #{self.id}
      GROUP BY polls.id) AS response_poll
    ON
      question_poll.pollsID = response_poll.pollsID
    JOIN
      polls
      ON
      question_poll.pollsID = polls.id
    WHERE TotalQuestions > TotalResponses
    AND TotalResponses >= 1
    SQL
    
    Poll.find_by_sql(query)
  end
  
end
