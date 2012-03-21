namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    
    admin.toggle!(:admin)
    #why not just add admin: true to the initialization hash? The answer is, it won’t work
    #this is by design: only attr_accessible attributes can be assigned through mass assignment
    #and the admin attribute isn’t accessible
    
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end