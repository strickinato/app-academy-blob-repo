class User < QuestionDatabaseObject
  attr_accessor :fname, :lname
  attr_reader :id
  
  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_id(lookup_id)
    query = <<-SQL 
    SELECT 
    * 
    FROM 
    users 
    WHERE 
    id = ? 
    SQL
    User.new(QuestionsDatabase.instance.execute(query, lookup_id).first)
  end
  
  def self.find_by_name(fname, lname)
    query = <<-SQL 
    SELECT 
    * 
    FROM 
    users 
    WHERE 
    fname = ? AND lname = ? 
    SQL
    User.new(QuestionsDatabase.instance.execute(query, fname, lname).first)
  end
  
  def authored_questions
    Question.find_by_author(@id)
  end
  
  def authored_replies
    Reply.find_by_user_id(@id)
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end
  
  def average_karma
    query = <<-SQL 
    SELECT 
    CAST(COUNT(DISTINCT(questions.id)) AS FLOAT) AS question_count, 
    COUNT(user_id) AS like_count
    FROM 
    questions LEFT OUTER JOIN question_likes ON questions.id = question_id 
    WHERE author_id = ?
    SQL
    
    karma_hash = QuestionsDatabase.instance.execute(query, @id).first
    
    karma_hash['like_count'] / karma_hash['question_count']
  end
end