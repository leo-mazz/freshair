FactoryGirl.define do
  factory :schedule do
    name 'semester 1'
    end_date 1.month.from_now.to_date
  end
end


FactoryGirl.define do
  factory :schedule_assignment do
    day_of_week 1
    start_time '2000-01-01 10:00:00'.to_time
    end_time '2000-01-01 11:00:00'.to_time
  end
end


FactoryGirl.define do
  factory :show do
    title 'Eve was Framed'
    description 'Cool show'
  end
end


FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    email 'john.doe@example.com'
    password 'safe_password'
    password_confirmation 'safe_password'
  end
end


FactoryGirl.define do
  factory :team do
    name 'Music'
  end
end
