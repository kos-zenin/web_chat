# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :messages, inverse_of: :user, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
