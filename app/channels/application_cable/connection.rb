# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      return ::User.find(session.fetch(:user_id)) if session.key?(:user_id)

      reject_unauthorized_connection
    end

    def session
      @request.session
    end
  end
end
