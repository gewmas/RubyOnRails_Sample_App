# Usage, FactoryBot.create(:user)

FactoryBot.define do
  sequence(:name)  { |n| "Person #{n}" }
  sequence(:email) { |n|  "person#{n}#{Time.new.usec}@example.com" }
  
  factory :user do
    name
    email
    password {'foobar' }
    password_confirmation { 'foobar' }

    factory :admin do
      admin { true }
    end
  end

  factory :micropost do
    content { 'Lorem ipsum' }
    user
  end
end
