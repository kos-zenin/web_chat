# frozen_string_literal: true

require "rails_helper"

describe ::CurrentChat do
  describe "#load" do
    context "when there is no chat available" do
      let(:new_chat) { build_stubbed(:chat) }

      before do
        expect(Chat).to receive(:create).and_return(new_chat)
      end

      it "returns new chat" do
        expect(subject.load).to eq(new_chat)
      end
    end

    context "when chat already exists" do
      let(:existing_chat) { create(:chat) }

      before do
        existing_chat
      end

      it "returns existing chat" do
        expect(subject.load).to eq(existing_chat)
      end
    end
  end
end
