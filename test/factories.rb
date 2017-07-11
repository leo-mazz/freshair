FactoryGirl.define do

  factory :schedule do
    name 'semester 1'

    factory :current_schedule do
      start_date Date.yesterday
      end_date Date.tomorrow
    end
  end


  factory :schedule_assignment do
    day_of_week 1
    start_time '2000-01-01 10:00:00'.to_time
    end_time '2000-01-01 11:00:00'.to_time
  end


  factory :show do
    title 'Eve was Framed'
    description 'Cool show'
  end


  factory :user do
    first_name 'John'
    last_name  'Doe'
    email 'john.doe@example.com'
    password 'safe_password'
    password_confirmation 'safe_password'
  end


  factory :team do
    name 'Music'
  end

end
