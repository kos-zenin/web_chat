import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ChatChannel" }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    this.appendMessage(data);
  },

  appendMessage(data) {
    const html = this.buildHtml(data)
    const element = document.querySelector(".chat-container")
    element.insertAdjacentHTML("beforeend", html)
  },

  buildHtml(data) {
    return `
      <div class="chat-message">
        <div class="chat-message__header">${data["created_at"]} | ${data["user_email"]}</div>
        <div class="chat-message__body">${data["content"]}</div>
      </div>
    `
  }
});
