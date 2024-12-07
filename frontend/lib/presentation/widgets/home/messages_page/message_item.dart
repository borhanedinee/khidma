import 'package:flutter/material.dart';
import 'package:khidma/domain/models/messages_model.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  final bool isCurrentUser;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              message.content,
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              formatDateTime(message.sentAt) ,
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Formatting time as `hh:mm a`
    final time =
        "${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'pm' : 'am'}";

    if (difference.inDays == 0 && now.day == dateTime.day) {
      // If the date is today
      return "Today at $time";
    } else if (difference.inDays <= 1 && now.day - dateTime.day == 1) {
      // If the date is yesterday
      return "Yesterday at $time";
    } else {
      // If the date is earlier than yesterday
      final weekday = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      return "${weekday[dateTime.weekday % 7]} at $time";
    }
  }
}
