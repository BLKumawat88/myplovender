class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent:
          "Lorem Ipsum is simply dummy text of the printing and typesetting",
      messageType: "receiver"),
  ChatMessage(
      messageContent:
          "Lorem Ipsum is simply dummy text of the printing and typesetting",
      messageType: "sender"),
];
