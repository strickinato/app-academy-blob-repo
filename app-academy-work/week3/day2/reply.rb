class Reply < QuestionDatabaseObject
  attr_accessor :question_id, :replier_id, :parent_reply_id, :body
  attr_reader :id
  
  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @replier_id = options['replier_id']
    @body = options['body'] 
  end
  
  def self.find_by_id(lookup_id)
    query = <<-SQL
    SELECT * FROM replies WHERE id = ?
    SQL
    Reply.new(QuestionsDatabase.instance.execute(query, lookup_id).first)
  end
  
  def self.find_by_question_id(question_id)
    query = <<-SQL
    SELECT * FROM replies WHERE question_id = ?
    SQL
    QuestionsDatabase.instance.execute(query, question_id)
  end
  
  def self.find_by_user_id(user_id)
    query = <<-SQL
    SELECT * FROM replies WHERE replier_id = ?
    SQL
    QuestionsDatabase.instance.execute(query, user_id)
  end
  
  def author
    query = <<-SQL
    SELECT fname, lname FROM users WHERE id = ?
    SQL
    name_hash = QuestionsDatabase.instance.execute(query, @replier_id).first
    name_string = "#{name_hash['fname']} #{name_hash['lname']}"
  end
  
  def question
    query = <<-SQL
    SELECT title, body FROM questions WHERE id = ?
    SQL
    question_hash = QuestionsDatabase.instance.execute(query, @question_id).first
    question_output = "Title:#{question_hash['title']} Body:#{question_hash['body']}"
  end
  
  def parent_reply
    raise "no parent" unless @parent_reply_id 
    query = <<-SQL
    SELECT body FROM replies WHERE id = ?
    SQL
    question_hash = QuestionsDatabase.instance.execute(query, @parent_reply_id ).first
    question_output = "#{question_hash['body']}"
  end
  
  def child_replies
    query = <<-SQL
    SELECT body FROM replies WHERE parent_reply_id = ?
    SQL
    question_hash = QuestionsDatabase.instance.execute(query, @id ).first
    question_output = "#{question_hash['body']}"
  end
  
end