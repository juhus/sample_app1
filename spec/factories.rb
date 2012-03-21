FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
    	admin true
    end
    
  end
end

# invoke FactoryGirl.create(:user)
# before(:all) { 30.times { FactoryGirl.create(:user) } }
# after(:all)  { User.delete_all } 