import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';
import 'package:khidma/presentation/controllers/chat/messages_controller.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

class SendMessageField extends StatefulWidget {
  const SendMessageField({
    super.key,
    required this.conversationid,
    required this.recieverid,
  });

  final int? conversationid;
  final int recieverid;

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  final SocketService chatsController = Get.find();
  final MessagesController messagesController = Get.find();
  final sendMessageController = TextEditingController();

  @override
  void dispose() {
    sendMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10,
      ),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: sendMessageController,
              onChanged: (value) {
                if (widget.conversationid != null) {
                  chatsController.onTyping(
                    value,
                    widget.recieverid,
                    widget.conversationid!,
                  );
                }
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Type a message...',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          sendMessageController.text.trim() == ''
              ? const SizedBox()
              : IconButton.filled(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  onPressed: () {
                    // SENDING MESSAGE TO USER AND TO DATABASE AND OPTIMISTIC UI
                  
                    chatsController.sendMessage(
                      sendMessageController.text,
                      widget.conversationid,
                      widget.recieverid,
                      getSavedUser().id,
                    );

                    sendMessageController.clear();
                  },
                ),
        ],
      ),
    );
  }
}
