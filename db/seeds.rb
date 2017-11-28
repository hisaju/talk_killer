##User
 99.times do |n|
   name  = Faker::Name.name
   email = "example-#{n+1}@test.com"
   password = "password"
   User.create!(id: n+1,
                provider: n+1,
                name:  name,
                email: email,
                password:              password,
                password_confirmation: password
               )
                #activated: true,
                #activated_at: Time.zone.now)
 end

##Talk
 users = User.order(:created_at).take(10)
 50.times do
   content = Faker::Lorem.sentence(5)
   users.each { |user| user.topics.create!(content: content) }
 end

#Comment
 50.times do |n|
   Comment.create!(   id:  n+1,
                 user_id:  n+1,
                talk_id:  n+1,
                content:   Faker::Lorem.sentence(3)
                )
 end
 
 