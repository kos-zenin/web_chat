# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :chat, inverse_of: :messages
  belongs_to :user, inverse_of: :messages

  validates :content, presence: true

  scope :after, ->(time: Time.current) { where("created_at >= :time", time: time) }
  scope :before, ->(time: Time.current) { where("created_at <= :time", time: time) }
  scope :in_period, ->(from: 1.week.ago, to: Time.current) { before(time: to).after(time: from) }
end
