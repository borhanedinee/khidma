import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/messages_model.dart';
import 'package:khidma/presentation/controllers/chat/conversations_controller.dart';
import 'package:khidma/presentation/controllers/chat/messages_controller.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/services/notification_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxController {
  final MessagesController messagesController;
  final ConversationsController conversationsController;

  late IO.Socket _socket;

  bool isConnected = false;
  bool isUserToTextTyping = false;
  List receivedMessages = <String>[];

  int currentConversationId = -1;

  SocketService({
    required this.messagesController,
    required this.conversationsController,
  });

  Future<void> connect() async {
    _socket = IO.io(
      BASE_URL, // Replace with your backend URL
      IO.OptionBuilder()
          .setTransports(['websocket']) // Specify WebSocket transport
          .disableAutoConnect() // Prevent auto-connection
          .build(),
    );

    // Connection established
    _socket.onConnect((_) {
      isConnected = true;
      print("Connected to Socket.IO");
    });

    // Listen for messages
    _socket.on('message', (data) {
      print("Message received: $data");
      receivedMessages.add(data); // Add the message to the list
    });

    // sent message status
    _socket.on('message-status', (data) async {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );

      // UPDATING THE MESSAGE STATUS
      for (var message in messagesController.messages) {
        if (message.tempId == data['tempid']) {
          if (data['success']) {
            message.status = 'sent';
            message.id = data['realid'];
          } else {
            message.status = 'failed';
          }
        }
      }

      //UPDATING CONVERSATION LAST MESSAGE
      for (var conversation in conversationsController.conversations) {
        if (conversation.convoid == data['conversationid']) {
          conversation.convoLastMsg = data['conversationlastmsg'];
          conversation.convoLastMsgSentAt = DateTime.parse(
            data['sentat'].toString(),
          );
        }
      }

      // SORING CONVERSATIONS
      // newer messages on top
      conversationsController.conversations.sort(
        (a, b) {
          return b.convoLastMsgSentAt.compareTo(a.convoLastMsgSentAt);
        },
      );
      // UPDATE UI
      conversationsController.update();
      messagesController.update();
    });

    // RECIEVE MESSAGE
    _socket.on('recievemessage', (data) {
      // show notification
      NotificationService.showNotification(
        title: 'Recieved a Message',
        body: data['message'],
      );

      // update messages
      final senderId = data['senderid'];
      final conversationId = data['conversationid'];
      final content = data['message'].toString();
      final sentAt = DateTime.now();
      const isMsgRead = true;
      final tempId = data['tempid'];

      messagesController.messages.add(MessageModel(
          conversationId: conversationId,
          senderId: senderId,
          content: content,
          sentAt: sentAt,
          isMsgRead: isMsgRead,
          tempId: tempId));
      isUserToTextTyping = false;
      messagesController.update();

      //update conversations
      for (var conversation in conversationsController.conversations) {
        if (conversation.convoid == conversationId) {
          conversation.convoLastMsg = content;
          conversation.convoLastMsgSentAt = DateTime.now();
          if ( conversation.convoid != currentConversationId ) {
            conversation.unreadMessagesCount =
                conversation.unreadMessagesCount + 1;
          }
        }
      }
      // SORING CONVERSATIONS
      // newer messages on top
      conversationsController.conversations.sort(
        (a, b) {
          return b.convoLastMsgSentAt.compareTo(a.convoLastMsgSentAt);
        },
      );
      conversationsController.update();
    });

    _socket.on(
      'recievetyping',
      (data) {
        // Check if the typing is for the current conversation
        if (data['currentconversationid'] == currentConversationId) {
          isUserToTextTyping = data['isTyping'];
          messagesController.update();
        }
      },
    );

    // Handle disconnection
    _socket.onDisconnect((_) {
      isConnected = false;
      print("Disconnected from Socket.IO");
    });

    // Connect to the server
    _socket.connect();
  }

  void connectUser(int userid) {
    _socket.emit('connectuserid', {'userid': userid});
  }

  void onTyping(
    String value,
    int recieverid,
    int currentConversationid,
  ) {
    _socket.emit('typing', {
      'recieverid': recieverid,
      'currentconversationid': currentConversationid,
      'isTyping': value.isNotEmpty, // True if there's input
    });
  }

  void sendMessage(
    String message,
    int conversationid,
    int recieverid,
    int senderid,
  ) {
    // OPTIMISTIC UI
    final tempid = DateTime.now().millisecondsSinceEpoch;
    final sentAt = DateTime.now();
    messagesController.messages.add(
      MessageModel(
          conversationId: conversationid,
          senderId: getSavedUser().id,
          content: message,
          sentAt: sentAt,
          isMsgRead: true,
          tempId: tempid,
          status: 'sending'),
    );
    messagesController.update();

    // SEND MESSAGE TO DATABASE
    Map messageData = {
      'message': message,
      'conversationid': conversationid,
      'senderid': senderid,
      'recieverid': recieverid,
      'tempid': tempid,
      'sentat': sentAt.toString()
    };
    if (isConnected) {
      _socket.emit('message', messageData);
    } else {
      print("Cannot send message. Not connected to Socket.IO.");
    }
  }

  void disconnect() {
    if (isConnected) {
      _socket.disconnect();
      isConnected = false;
      print("Disconnected from Socket.IO");
    }
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }

  // update local messages
  void addMessageToMessages(
    String message,
    int conversationid,
    int recieverid,
    int senderid,
  ) {}
}
