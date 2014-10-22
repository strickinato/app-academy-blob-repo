CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL, 
  body TEXT NOT NULL,
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  replier_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (replier_id) REFERENCES users(id)
  
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('John', 'Kim'), ('Aaron', 'Strick'), ('Bruce', 'Willis'), ('Jackie', 'Chan');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Johns Question','How do I do SQL?',(SELECT id FROM users WHERE fname = 'John' AND lname = 'Kim')),
  ('Johns Second Question','How do I do Ruby?',(SELECT id FROM users WHERE fname = 'John' AND lname = 'Kim')),
  ('Aarons Question','Where can I buy a donut?',(SELECT id FROM users WHERE fname = 'Aaron' AND lname = 'Strick')),
  ('Aarons Second Question','Where can I buy milk?', (SELECT id FROM users WHERE fname = 'Aaron' AND lname = 'Strick'));
INSERT INTO
  question_followers(follower_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bruce' AND lname = 'Willis'),(SELECT id FROM questions WHERE id = 2)),
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Kim'),(SELECT id FROM questions WHERE id = 3)),
  ((SELECT id FROM users WHERE fname = 'Jackie' AND lname = 'Chan'), (SELECT id FROM questions WHERE id = 2)),
  ((SELECT id FROM users WHERE fname = 'Jackie' AND lname = 'Chan'), (SELECT id FROM questions WHERE id = 3)),
  ((SELECT id FROM users WHERE fname = 'Aaron' AND lname = 'Strick'), (SELECT id FROM questions WHERE id = 2)),
  ((SELECT id FROM users WHERE fname = 'Aaron' AND lname = 'Strick'), (SELECT id FROM questions WHERE id = 1));
INSERT INTO
  replies(question_id, parent_reply_id, replier_id, body)
VALUES
  ((SELECT id FROM questions WHERE id = 1), null, (SELECT id FROM users WHERE fname = 'Bruce' AND lname = 'Willis'), 'What a dumb question!'),
  ((SELECT id FROM questions WHERE id = 1), 1, (SELECT id FROM users WHERE fname = 'Jackie' AND lname = 'Chan'), 'Dont be mean!');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Kim'),
  (SELECT id FROM questions WHERE id = 2)),
  ((SELECT id FROM users WHERE fname = 'Bruce' AND lname = 'Willis'),
  (SELECT id FROM questions WHERE id = 3)),
  ((SELECT id FROM users WHERE fname = 'Jackie' AND lname = 'Chan'),
  (SELECT id FROM questions WHERE id = 3)),
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Kim'),
  (SELECT id FROM questions WHERE id = 2)),
  ((SELECT id FROM users WHERE fname = 'Bruce' AND lname = 'Willis'),
  (SELECT id FROM questions WHERE id = 2)),
  ((SELECT id FROM users WHERE fname = 'Aaron' AND lname = 'Strick'),
  (SELECT id FROM questions WHERE id = 1));