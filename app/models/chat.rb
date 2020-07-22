# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :messages, inverse_of: :chat, dependent: :destroy

  def self.instance
    first || create
  end
end
