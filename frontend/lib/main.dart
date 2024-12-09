import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/data/user_api.dart';
import 'package:khidma/presentation/controllers/auth/login_controller.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';
import 'package:khidma/presentation/controllers/chat/conversations_controller.dart';
import 'package:khidma/presentation/controllers/chat/messages_controller.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/controllers/home/applications_controller.dart';
import 'package:khidma/presentation/controllers/home/edit_application_controller.dart';
import 'package:khidma/presentation/controllers/home/preview_application_controller.dart';
import 'package:khidma/presentation/controllers/home/submitting_application_controller.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/controllers/home/home_controller.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/controllers/home/profile_controller.dart';
import 'package:khidma/presentation/controllers/onboarding_controller.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_page.dart';
import 'package:khidma/presentation/pallets/colors.dart';
import 'package:khidma/presentation/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  prefs = await SharedPreferences.getInstance();
  prefs.setBool('isauthenticated', false);

  final messagesController = Get.put(MessagesController());
  final conversationsController = Get.put(ConversationsController());
  final socketService = Get.put(
    SocketService(
      messagesController: messagesController,
      conversationsController: conversationsController,
    ),
  );
  Get.lazyPut(
      () => LoginController(
            userApi: UserApi(),
            socketService: socketService,
          ),
      fenix: true);

  socketService.connect(); // Establish connection
  runApp(const Khidma());
}

late Size size;

class Khidma extends StatelessWidget {
  const Khidma({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.white70,
          ),
        ),
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          // seedColor:  Colors.redAccent,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: prefs.getString('userfullname') == null
          ? const OnBoardingPage()
          : const MainPage(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => OnBoardingController(), fenix: true);
        Get.lazyPut(
          () => MyDrawerController(),
          fenix: true,
        );
        Get.lazyPut(() => ProfileController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.lazyPut(() => JobRequirementsController(), fenix: true);
        Get.lazyPut(() => BookmarksController(), fenix: true);
        Get.lazyPut(() => SubmittingApplicationController(), fenix: true);
        Get.lazyPut(() => EditApplicationController(), fenix: true);
        Get.lazyPut(() => ApplicationsController(), fenix: true);
        Get.lazyPut(() => ConversationsController(), fenix: true);
        Get.lazyPut(() => MessagesController(), fenix: true);
        Get.lazyPut(() => PreviewApplicationController(), fenix: true);
      }),
    );
  }
}
