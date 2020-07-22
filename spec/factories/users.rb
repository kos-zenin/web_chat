# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "user_#{SecureRandom.hex}@user.com" }
    password { "123" }
  end
end
