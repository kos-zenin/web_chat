# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authorize_user!

  def index
    @chat = Chat.instance
  end
end
