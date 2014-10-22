class QuestionDatabaseObject
  DATABASES = {
    'User' => 'users',
    'Question' => 'questions',
    'QuestionFollower' => 'question_followers',
    'Reply' => 'replies',
    'QuestionLike' => 'question_likes'
  }

  
  def save    
    database = DATABASES[self.class.to_s]    
    set_vars = get_sql_set_vars
    insert_vars = get_sql_insert_vars
    argument_variables = get_argument_variables
    q_marks_string = get_q_mark_string
    
    if @id
      query = <<-SQL
      UPDATE
      #{database}
      SET
       #{set_vars}
      WHERE
        id = ?
      SQL
      QuestionsDatabase.instance.execute(query, *argument_variables, @id)
    else
      query = <<-SQL
      INSERT INTO 
        #{database} #{insert_vars}
      VALUES
      #{q_marks_string}
      SQL
      QuestionsDatabase.instance.execute(query, *argument_variables)
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end
  private
  
  def get_instance_variables
    instance_variables = self.instance_variables
    instance_variables.delete(:@id)
    instance_variables
  end
  
  def get_argument_variables
    get_instance_variables.map do |var|
      var = instance_variable_get(var[0...var.length])
    end
  end
  
  def get_stripped_variables
    get_instance_variables.map do |var| 
      var = var[1...var.length]
    end
  end
  
  def get_sql_set_vars
    stripped_instance_variables = get_stripped_variables
    set_vars = "#{stripped_instance_variables.join(' = ?, ')} = ?"  
  end
  
  def get_sql_insert_vars
    stripped_instance_variables = get_stripped_variables
    insert_vars = "(#{stripped_instance_variables.join(',')})"
  end
  
  def get_q_mark_string
    stripped_instance_variables = get_stripped_variables
    q_marks = []
    stripped_instance_variables.size.times { q_marks << '?' }
    q_marks_string = "( #{q_marks.join(',')} )"
  end
end
