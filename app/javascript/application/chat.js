const scrollChatDown = () => {
  const chatContainer = document.querySelector(".chat-container");
  chatContainer.scrollTop = chatContainer.scrollHeight;
}

window.onload = () => {
  scrollChatDown();
}

export { scrollChatDown };
