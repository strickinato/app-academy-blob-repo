PREFIXES = ["An ode to", "Love and", "", "If only", "She told me", "My baby and" ]

User.create!(
  email: 'aaronstrick@gmail.com',
  password: 'hello123'
)



15.times do |i|
  i = (i + 1)
  User.create!(
    email: Faker::Internet.safe_email,
    password: Faker::Lorem.word + "hello"
  )
end

20.times do |i|
  i = (i + 1)
  Band.create!(name: "#{Faker::Name.name} and the #{Faker::Commerce.product_name}'s")

  5.times do |j|
    j = (j + 1)
    selection = ['studio', 'live']
    Album.create!(
    title: "#{Faker::Hacker.adjective.capitalize} #{Faker::Lorem.word} #{Faker::Company.suffix}",
    band_id: i,
    recording_type: selection.sample
    )

    10.times do |k|
      Track.create!(
        title: "#{PREFIXES.sample} #{Faker::Company.bs}",
        album_id: (((i-1) * 5) + j),
        ord: (k + 1),
        lyrics: Faker::Lorem.sentences(30).join("\n")
      )
    end
  end
end

2000.times do
  Note.create(
    user_id: (rand(15) + 1),
    track_id: rand(1000),
    track_note: Faker::Hacker.say_something_smart
  )
end
