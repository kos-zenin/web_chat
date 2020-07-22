# frozen_string_literal: true

require "rails_helper"

describe ::ChatChannel, type: :channel do
  describe "#subscribed" do
    it "successfully subscribes" do
      subscribe

      expect(subscription).to be_confirmed
    end
  end
end
