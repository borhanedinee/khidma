import 'package:khidma/domain/models/user_model.dart';

class ConversationModel {
  final int convoid;
  final String convoLastMsg;
  final DateTime convoLastMsgSentAt;
  final DateTime convoCreatedAt;
  final UserModel usera;
  final UserModel userb;
  int unreadMessagesCount;

  ConversationModel({
    required this.convoid,
    required this.convoLastMsg,
    required this.convoLastMsgSentAt,
    required this.convoCreatedAt,
    required this.usera,
    required this.userb,
    required this.unreadMessagesCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      convoid: json['convoid'],
      convoLastMsg: json['convoLastMsg'],
      convoLastMsgSentAt: DateTime.parse(json['convoLastMsgSentAt']),
      convoCreatedAt: DateTime.parse(json['convoCreatedAt']),
      usera: UserModel.fromJson(json['usera']),
      userb: UserModel.fromJson(json['userb']),
      unreadMessagesCount: json['unreadMessagesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'convoid': convoid,
      'convoLastMsg': convoLastMsg,
      'convoLastMsgSentAt': convoLastMsgSentAt.toIso8601String(),
      'convoCreatedAt': convoCreatedAt.toIso8601String(),
      'usera': usera.toJson(),
      'userb': userb.toJson(),
      'unreadMessagesCount': unreadMessagesCount,
    };
  }

  updateUnreadMessagesCountToZERO(){
    unreadMessagesCount = 0;
  }
}

