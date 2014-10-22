class Question < QuestionDatabaseObject
  attr_accessor :title, :author_id, :body
  attr_reader :id
  
  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @author_id = options['author_id']
    @body = options['body']
  end
  
  def self.find_by_id(lookup_id)
    query = <<-SQL
    SELECT * FROM questions WHERE id = ?
    SQL
    Question.new(QuestionsDatabase.instance.execute(query, lookup_id).first)
  end
  
  def self.find_by_author(author_id)
    query = <<-SQL
    SELECT * FROM questions WHERE author_id = ?
    SQL
    QuestionsDatabase.instance.execute(query, author_id)  
  end
  
  def author
    query = <<-SQL
    SELECT fname, lname FROM users WHERE id = ?
    SQL
    name_hash = QuestionsDatabase.instance.execute(query, @author_id).first
    name_string = "#{name_hash['fname']} #{name_hash['lname']}"
  end
  
  def replies
    Reply.find_by_question_id(@id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(@id)
  end
  
  def most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def likers
    QuestionLike.likers_for_question_id(@id)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
  
  def most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end
