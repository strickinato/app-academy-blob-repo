class QuestionFollower < QuestionDatabaseObject
  attr_accessor :follower_id, :question_id
  attr_reader :id
  
  def initialize(options = {})
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end
  
  def self.find_by_id(lookup_id)
    query = <<-SQL
    SELECT 
    * 
    FROM 
    question_followers 
    WHERE 
    id = ?
    SQL
    
    row_data = QuestionsDatabase.instance.execute(query, lookup_id).first
    QuestionFollower.new(row_data)
  end
  
  def self.followers_for_question_id(question_id)
    query = <<-SQL
    SELECT 
    users.id, fname, lname 
    FROM 
    question_followers 
    JOIN 
    users ON follower_id = users.id 
    WHERE question_id = ?
    SQL
    
    users = []
    QuestionsDatabase.instance.execute(query, question_id).each do |user_info|
      users << User.new(user_info)
    end
    users  
  end
  
  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT 
    questions.id, title, author_id, body 
    FROM question_followers 
    JOIN questions ON question_id = questions.id WHERE follower_id = ?
    SQL
    questions = []
    QuestionsDatabase.instance.execute(query, user_id).each do |question_info|
      questions << Question.new(question_info)
    end
    questions  
  end
  
  def self.most_followed_questions(n)
    query = <<-SQL
    SELECT question_id, questions.id, title, author_id, body 
    FROM questions JOIN question_followers ON questions.id = question_id
    GROUP BY question_id
    ORDER BY COUNT(question_id) DESC
    LIMIT ?
    SQL
    questions = []
    QuestionsDatabase.instance.execute(query, n).each do |question_info|
      questions << Question.new(question_info)
    end
    questions
  end  
end
