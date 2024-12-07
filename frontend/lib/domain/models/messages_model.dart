class MessageModel {
  final int id;
  final int conversationId;
  final int senderId;
  final String content;
  final DateTime sentAt;
  final bool isMsgRead;
  final DateTime? readAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.sentAt,
    required this.isMsgRead,
    this.readAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversationid'],
      senderId: json['senderid'],
      content: json['content'],
      sentAt: DateTime.parse(json['sentat']),
      isMsgRead: json['ismsgread'] == 1,
      readAt: json['readat'] != null ? DateTime.parse(json['readat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationid': conversationId,
      'senderid': senderId,
      'content': content,
      'sentat': sentAt.toIso8601String(),
      'ismsgread': isMsgRead ? 1 : 0,
      'readat': readAt?.toIso8601String(),
    };
  }
}
