enum ChatSender { user, bot }

class ChatMessage {
  ChatMessage({required this.text, required this.type});
  String? text;
  ChatSender? type;
}
