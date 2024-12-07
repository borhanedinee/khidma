import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';

class SendMessageField extends StatelessWidget {
  SendMessageField({
    super.key,
  });

  final SocketService chatsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              chatsController.sendMessage('hey how are you');
              // Implement send functionality here
            },
          ),
        ],
      ),
    );
  }
}
