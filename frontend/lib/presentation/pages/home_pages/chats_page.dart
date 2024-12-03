import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/chats_page/empty_chats.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';

import 'package:lottie/lottie.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
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
                    child: ListView(
                      children: const [
                        EmptyChats(),
                      ],
                    ),
                  ),
                  const MyTopShaddow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
