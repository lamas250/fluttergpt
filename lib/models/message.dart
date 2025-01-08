enum MessageType { user, ai }

class Message {
  final String content;
  final MessageType type;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.type,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
