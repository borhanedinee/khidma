import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/conversation_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';
import 'package:khidma/presentation/controllers/chat/conversations_controller.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/chats_page/conversation_item.dart';
import 'package:khidma/presentation/widgets/home/chats_page/empty_chats.dart';
import 'package:khidma/presentation/widgets/home/chats_page/fetching_conversations.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
import 'package:khidma/presentation/widgets/home/proceed_to_login.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  ConversationsController conversationsController = Get.find();

  @override
  void initState() {
    if (prefs.getBool('isauthenticated')!) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        conversationsController.fetchConversations(getSavedUser().id);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              const MyAppBar(
                label: 'Chats',
              ),
              Positioned.fill(
                top: 80,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: !prefs.getBool('isauthenticated')!
                          ? const ProceedToLogin()
                          : GetBuilder<ConversationsController>(
                              builder: (controller) => ListView(
                                children: [
                                  controller.isFetchingConversationsLoading
                                      ? const FetchingChats()
                                      : controller.conversations.isNotEmpty
                                          ? Column(children: [
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              ...List.generate(
                                                  controller.conversations
                                                      .length, (index) {
                                                final ConversationModel
                                                    conversation = controller
                                                        .conversations[index];
                                                return ConversationItem(
                                                  conversation: conversation,
                                                );
                                              }),
                                            ])
                                          : const EmptyChats(),
                                ],
                              ),
                            ),
                    ),
                    const MyTopShaddow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
