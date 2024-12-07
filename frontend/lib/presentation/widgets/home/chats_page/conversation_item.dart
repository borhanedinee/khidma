import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/conversation_model.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/conversations_controller.dart';
import 'package:khidma/presentation/pages/home_pages/messages_page.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

class ConversationItem extends StatelessWidget {
  final ConversationModel conversation;

  ConversationItem({
    super.key,
    required this.conversation,
  });

  final ConversationsController conversationsController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('build');
    UserModel userToText = conversation.usera.id == getSavedUser().id
        ? conversation.userb
        : conversation.usera;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            InkWell(
              excludeFromSemantics: true,
              onTap: () {
                print('convo item clicked');

                Get.to(
                  () => MessagesPage(
                    needToUpdateUnreadMessages:
                        conversation.unreadMessagesCount > 0,
                    conversationId: conversation.convoid,
                    userToText: userToText,
                  ),
                );
                conversation.updateUnreadMessagesCountToZERO();
                conversationsController.update();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    // Leading Avatar
                    GestureDetector(
                      onTap: () {
                        print('convo item clicked');
                        Get.to(
                          () => MessagesPage(
                            needToUpdateUnreadMessages:
                                conversation.unreadMessagesCount > 0,
                            conversationId: conversation.convoid,
                            userToText: userToText,
                          ),
                        );
                        conversation.updateUnreadMessagesCountToZERO();
                        conversationsController.update();
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          userToText.avatar.isNotEmpty
                              ? '$IMAGE_URL/${conversation.usera.avatar}'
                              : 'https://via.placeholder.com/150', // Placeholder for missing image
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 12), // Spacing between avatar and content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // userToText's full name
                              Text(
                                userToText.fullname,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Timestamp
                              Text(
                                formatTime(conversation.convoLastMsgSentAt),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 4), // Spacing between title and subtitle
                          Row(
                            children: [
                              // Last message
                              Expanded(
                                child: Text(
                                  conversation.convoLastMsg,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight:
                                        conversation.unreadMessagesCount > 0
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Unread message count
                              if (conversation.unreadMessagesCount > 0)
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    "${conversation.unreadMessagesCount}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }

  /// Helper to format the timestamp
  String formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hrs ago";
    } else {
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }
}
