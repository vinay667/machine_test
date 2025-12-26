class ChatModel {
  int id;
  String message;
  String msgTime;
  String filePath;
  String messageType;

  ChatModel({
    required this.id,
    required this.message,
    required this.msgTime,
    required this.filePath,
    required this.messageType,
  });

  factory ChatModel.fromMap(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      message: json['message'],
      msgTime: json['msg_time'],
      filePath: json['filePath'],
      messageType: json['message_type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'msg_time': msgTime,
      'filePath': filePath,
      'message_type': messageType,
    };
  }
}
