class Message {
  final String email;
  final String content;

  Message({required this.email, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'content': content,
    };
  }
}
