import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/auth/login_controller.dart';
import 'package:khidma/presentation/pages/auth/signup_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:khidma/presentation/widgets/home/my_form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<LoginController>(
            builder: (controller) => SizedBox(
              height: size.height - 50,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 30,
                    child: Image.asset(
                      'assets/images/helloo.png',
                      height: 250,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: size.height,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.navigate_before_rounded,
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    'Login',
                                    style: textTheme.titleMedium!.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Welcome Back!',
                              style: textTheme.headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, top: 5),
                            child: Text(
                              'Fill the details to login to your account',
                              style: textTheme.bodySmall!
                                  .copyWith(color: Colors.black45),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                MyFormField(
                                  fieldController: emailController,
                                  validator: (input) {
                                    if (input == '') {
                                      return 'Email field must not be empty.';
                                    }
                                    if (!GetUtils.isEmail(input!)) {
                                      return 'Please enter a valid email.';
                                    }
                                    return null;
                                  },
                                  hintText: 'Email...',
                                  isPassword: false,
                                ),
                                MyFormField(
                                  fieldController: passwordController,
                                  validator: (input) {
                                    if (input == '') {
                                      return 'Password field must not be empty.';
                                    }
                                    if (input!.length < 6) {
                                      return 'Password must be at least 6 characters.';
                                    }
                                    return null;
                                  },
                                  hintText: 'Password...',
                                  isPassword: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          controller.isLogingLoading
                              ? Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 30),
                                    width: 20,
                                    height: 20,
                                    child: const CircularProgressIndicator(),
                                  ),
                                )
                              : MyFilledButton(
                                  label: 'L O G I N',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.login(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: textTheme.bodySmall!
                                      .copyWith(color: Colors.black),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const SignupPage());
                                  },
                                  child: Text(
                                    'Register',
                                    style: textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
