FactoryBot.define do
  factory :user do
    email { "Test@test.com" }
    encrypted_password { "Password" }
    confirmation_token { "Confirmation Token" }
    remember_token { "Remember Token" }
    is_admin { false }

    created_at { DateTime.new(2020, 12, 31) }
    updated_at { DateTime.new(2020, 12, 31) }

    to_create {|instance| instance.save(validate: false) }
  end
end
