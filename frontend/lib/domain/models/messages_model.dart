class MessageModel {
  int? id; // Real ID from the database, nullable before insertion
  final int conversationId;
  final int senderId;
  final String content;
  final DateTime sentAt;
  final bool isMsgRead;
  final DateTime? readAt;
  String? status;
  final int tempId; // Temporary ID for optimistic UI

  MessageModel({
    this.id, // Real ID may be null before insertion
    required this.conversationId,
    required this.senderId,
    this.status,
    required this.content,
    required this.sentAt,
    required this.isMsgRead,
    this.readAt,
    required this.tempId, // Required tempId for optimistic UI
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversationid'],
      senderId: json['senderid'],
      status: json['status'],
      content: json['content'],
      sentAt: DateTime.parse(json['sentat']),
      isMsgRead: json['ismsgread'] == 1,
      readAt: json['readat'] != null ? DateTime.parse(json['readat']) : null,
      tempId: json['tempId'] ?? 0, // Get tempId if provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationid': conversationId,
      'senderid': senderId,
      'content': content,
      'status': status,
      'sentat': sentAt.toIso8601String(),
      'ismsgread': isMsgRead ? 1 : 0,
      'readat': readAt?.toIso8601String(),
      'tempId': tempId, // Send tempId for optimistic UI
    };
  }
}
