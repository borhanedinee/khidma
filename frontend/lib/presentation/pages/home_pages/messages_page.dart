import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';
import 'package:khidma/presentation/controllers/chat/messages_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/messages_page/message_item.dart';
import 'package:khidma/presentation/widgets/home/messages_page/send_message_field.dart';
import 'package:khidma/presentation/widgets/home/my_loading_item.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MessagesPage extends StatefulWidget {
  final int? conversationId;
  final UserModel userToText;
  final bool needToUpdateUnreadMessages;

  const MessagesPage({
    super.key,
    this.conversationId,
    required this.userToText,
    required this.needToUpdateUnreadMessages,
  });

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  MessagesController messagesController = Get.find();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.conversationId != null) {
        messagesController.fetchMessages(widget.conversationId!).then((_) {
          _scrollToBottom();
        });
        messagesController.markAllMessagesAsRead(
          widget.conversationId!,
          widget.userToText.id,
        );
        socketService.currentConversationId = widget.conversationId!;
      } else {
        messagesController.messages.clear();
      }
    });

    super.initState();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // waiting for the widget tree to update ( means the list view will be
      // on the widget tree then calling this method)
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  SocketService socketService = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: GetBuilder<MessagesController>(
          builder: (controller) => SizedBox(
            height: size.height,
            width: size.width,
            child: controller.isFetchingMessagesLoading
                ? const LoadingItem(
                    loadingLabel: 'Loading Messages',
                    lottieAsset: 'assets/lottie/loading_messages_lottie.json',
                  )
                : SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 0,
                          bottom: 70,
                          child: widget.conversationId == null
                              ? _startYourFirstConversation(controller)
                              : _loadOldConversation(),
                        ),
                        Positioned(
                          bottom: 0,
                          child: SendMessageField(
                            conversationid: widget.conversationId,
                            recieverid: widget.userToText.id,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
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
    );
  }

  ListView _loadOldConversation() {
    // means the passed conversation id is not null
    return ListView.builder(
      controller: scrollController,
      itemCount: messagesController.messages.length +
          (socketService.isUserToTextTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (socketService.isUserToTextTyping &&
            index == messagesController.messages.length) {
          return _typingIndicator();
        } else if (messagesController.messages.isNotEmpty &&
            index < messagesController.messages.length) {
          final message = messagesController.messages[index];
          final isCurrentUser = message.senderId == getSavedUser().id;

          // when adding new message scroll to bottom
          _scrollToBottom();

          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 30 : 0,
            ),
            child: Column(
              children: [
                index == 0 ? _userAvatarAboveMessages() : const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: index == messagesController.messages.length - 1
                        ? 20.0
                        : 0.0,
                  ),
                  child: MessageItem(
                    isCurrentUser: isCurrentUser,
                    message: message,
                  ),
                ),
              ],
            ),
          );
        }
        return null;
      },
    );
  }

  ListView _startYourFirstConversation(MessagesController controller) {
    return ListView(
      children: [
        SizedBox(
          height: 160,
        ),
        _userAvatarAboveMessages(),
        controller.messages.isNotEmpty
            ? Column(
                children: List.generate(controller.messages.length, (index) {
                  final message = controller.messages[index];
                  bool isCurrentUser = message.senderId == getSavedUser().id;
                  return MessageItem(
                    isCurrentUser: isCurrentUser,
                    message: message,
                  );
                }),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Start your conversation with the applicant. Please be polite.',
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }

  Widget _typingIndicator() {
    return Container(
      width: 50,
      margin: const EdgeInsets.only(
        right: 300,
        left: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const DotLoader(), // Custom animation widget
    );
  }

  Column _userAvatarAboveMessages() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            widget.userToText.avatar.isNotEmpty
                ? '$IMAGE_URL/${widget.userToText.avatar}'
                : 'https://via.placeholder.com/150', // Placeholder for missing image
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.userToText.fullname,
          style: textTheme.titleMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class DotLoader extends StatelessWidget {
  const DotLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 10,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse, // Three dots animation
        colors: [Colors.grey],
        strokeWidth: 2,
      ),
    );
  }
}
