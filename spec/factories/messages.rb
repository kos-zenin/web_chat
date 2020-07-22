# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    chat
    user
    content { SecureRandom.hex }
  end
end
