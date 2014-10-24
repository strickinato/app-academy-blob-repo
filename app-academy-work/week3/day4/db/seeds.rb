10.times do
  User.create!(user_name: Faker::Name.first_name)
end

2.times do |i|
  Poll.create!(author_id: (i + 1), title: Faker::Lorem.sentence(2))
end

5.times do |i|
  Question.create!(poll_id: 1, text: Faker::Lorem.sentence(3) )
  Question.create!(poll_id: 2, text: Faker::Lorem.sentence(3) )
end

10.times do |i|
  AnswerChoice.create!(question_id: (i + 1), text: "Answer choice 1")
  AnswerChoice.create!(question_id: (i + 1), text: "Answer choice 2")
end

5.times do |i|
  Response.create!(user_id: 3, answer_choice_id: 2 * (i + 1))
end
 
 
3.times do |i|
  Response.create!(user_id: 4, answer_choice_id: 2 * (i + 1))
end

3.times do |i|
  Response.create!(user_id: 5, answer_choice_id: (2 * (i + 1)) + 10 )
end

10.times do |i|
  Response.create!(user_id: 6, answer_choice_id: (i + 1) * 2)
end







# 15.times do
#   User.create!(user_name: Faker::Name.first_name)
# end
#
#
#
# user = User.all
#
# 10.times do |i|
#   Poll.create!(author_id: (i + 1), title: Faker::Lorem.sentence(3) )
# end
#
# 10.times do |i|
#   4.times do |j|
#    Question.create!(poll_id: (i + 1), text: Faker::Lorem.sentence(4))
#    3.times do |k|
#      AnswerChoice.create!(question_id: (j + 1), text: Faker::Lorem.sentence(1))
#    end
#   end
# end
#
# 5.times do |i|
#   10.times do |j|
#     Response.create!(user_id: (j + 1), answer_choice_id: (j + 1 ))
#   end
# end
#
#
#
#
