import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/messages_model.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/messages_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_appbar.dart';
import 'package:khidma/presentation/widgets/home/messages_page/message_item.dart';
import 'package:khidma/presentation/widgets/home/messages_page/send_message_field.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';

class MessagesPage extends StatefulWidget {
  final int conversationId;
  final UserModel userToText;
  final bool needToUpdateUnreadMessages;

  const MessagesPage({
    super.key,
    required this.conversationId,
    required this.userToText,
    required this.needToUpdateUnreadMessages,
  });

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  MessagesController messagesController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      messagesController.fetchMessages(widget.conversationId);
      if (widget.needToUpdateUnreadMessages) {
        messagesController.markAllMessagesAsRead(
          widget.conversationId,
          widget.userToText.id,
        );
      }
    });
    super.initState();
  }

  final int currentUserId = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {},
            )
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.navigate_before,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 5,
          title: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  widget.userToText.avatar.isNotEmpty
                      ? '$IMAGE_URL/${widget.userToText.avatar}'
                      : 'https://via.placeholder.com/150', // Placeholder for missing image
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.userToText.fullname,
                style: textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<MessagesController>(
          builder: (controller) => SizedBox(
            height: size.height,
            width: size.width,
            child: controller.isFetchingMessagesLoading
                ? const Center(
                    child: Text('Fetching messages ...'),
                  )
                : SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 0,
                          child: ListView.builder(
                            itemCount: messagesController.messages.length,
                            itemBuilder: (context, index) {
                              final message =
                                  messagesController.messages[index];
                              final isCurrentUser =
                                  message.senderId == currentUserId;

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 30 : 0,
                                ),
                                child: Column(
                                  children: [
                                    index == 0
                                        ? Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage(
                                                  widget.userToText.avatar
                                                          .isNotEmpty
                                                      ? '$IMAGE_URL/${widget.userToText.avatar}'
                                                      : 'https://via.placeholder.com/150', // Placeholder for missing image
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                widget.userToText.fullname,
                                                style: textTheme.titleMedium!
                                                    .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    MessageItem(
                                      isCurrentUser: isCurrentUser,
                                      message: message,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                         Positioned(
                          bottom: 0,
                          child: SendMessageField(),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
