import 'package:get/get.dart';
import 'package:khidma/data/conversation_api.dart';
import 'package:khidma/domain/models/conversation_model.dart';

class ConversationsController extends GetxController {
  ConversationAPI conversationAPI = ConversationAPI();

  // fetch vonversations
  bool isFetchingConversationsLoading = false;
  List<ConversationModel> conversations = [];
  fetchConversations(int userid) async {
    try {
      conversations.clear();

      isFetchingConversationsLoading = true;
      update();

      await Future.delayed(
        const Duration(seconds: 3),
      );

      List result = await conversationAPI.fetchConversations(userid);

      if (result.isNotEmpty) {
        for (var conversation in result) {
          conversations.add(
            ConversationModel.fromJson(conversation),
          );
        }
      }

      Get.showSnackbar(
        const GetSnackBar(
          message: 'Conversations fetched successfully',
          duration: Duration(seconds: 3),
        ),
      );
      
      isFetchingConversationsLoading = false;
      update();
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Failed to fetch conversations',
          duration: Duration(seconds: 3),
        ),
      );
      isFetchingConversationsLoading = false;
      update();
    }
  }
}
