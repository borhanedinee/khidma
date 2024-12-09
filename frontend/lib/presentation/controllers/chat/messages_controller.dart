import 'package:get/get.dart';
import 'package:khidma/data/messages_api.dart';
import 'package:khidma/domain/models/messages_model.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

class MessagesController extends GetxController {
  MessagesAPI messagesAPI = MessagesAPI();

  // fetching messages to conversation
  bool isFetchingMessagesLoading = false;
  List<MessageModel> messages = [];
  fetchMessages(int conversationid) async {
    try {
      messages.clear();
      isFetchingMessagesLoading = true;
      update();

      await Future.delayed(
        const Duration(seconds: 3),
      );

      List results = await messagesAPI.fetchMessages(conversationid);
      if (results.isNotEmpty) {
        for (var message in results) {
          messages.add(
            MessageModel.fromJson(message),
          );
        }
      }

      isFetchingMessagesLoading = false;
      update();
    } catch (e) {
      isFetchingMessagesLoading = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong fetching messages $e',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // mark all messages as read when user clicks on the conversation
  void markAllMessagesAsRead(int conversationid, int senderid) async {
    try {
      print('ccccccc');
      bool result =
          await messagesAPI.markAllMessagesAsRead(conversationid, senderid);
      if (result != true) {
        throw Exception();
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong marking messages as read $e',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
