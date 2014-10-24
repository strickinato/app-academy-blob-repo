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
  WHERE responses.user_id = 6
  GROUP BY polls.id) AS response_poll
ON
  question_poll.pollsID = response_poll.pollsID
JOIN
  polls
  ON
  question_poll.pollsID = polls.id
WHERE TotalQuestions = TotalResponses