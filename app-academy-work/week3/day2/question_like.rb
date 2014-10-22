class QuestionLike
  attr_accessor :question_id, :user_id
  attr_reader :id
  
  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(lookup_id)
    query = <<-SQL
    SELECT * FROM question_likes WHERE id = ?
    SQL
    QuestionLike.new(QuestionsDatabase.instance.execute(query, lookup_id).first)
  end
  
  def self.likers_for_question_id(question_id)
    query = <<-SQL
    SELECT users.id, fname, lname 
    FROM question_likes JOIN users
    ON user_id = users.id
    WHERE question_id = ?
    SQL
    # users = []
    row_data = QuestionsDatabase.instance.execute(query, question_id)
    row_data.map do |user_info|
      User.new(user_info)
    end
    # users
  end
  
  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
    SELECT COUNT(question_id) AS count
    FROM question_likes
    WHERE question_id = ?
    SQL
    
    result = QuestionsDatabase.instance.execute(query, question_id).first
    p result
    result["count"]
  end
  
  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT questions.id, title, author_id, body
    FROM question_likes JOIN questions ON questions.id = question_id
    WHERE user_id = ?
    SQL
    questions = []
    QuestionsDatabase.instance.execute(query, user_id).each do |question_info|
      questions << Question.new(question_info)
    end
    questions
  end
  
  def self.most_liked_questions(n)
    query = <<-SQL
    SELECT questions.id, body, title, author_id, question_id
    FROM question_likes JOIN questions ON questions.id = question_id
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