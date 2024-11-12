import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:khidma/presentation/widgets/home/my_form_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
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
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(.7)),
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
                                  'Signup',
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
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Hello, Welcome!',
                            style: textTheme.headlineLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            'Fill the details to sign up for an account',
                            style: textTheme.bodyMedium!
                                .copyWith(color: Colors.black45),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        
                        const MyFormField(
                          hintText: 'Full name',
                          isObsecure: false,
                        ),
                        const MyFormField(
                          hintText: 'Email',
                          isObsecure: false,
                        ),
                        const MyFormField(
                          hintText: 'Password',
                          isObsecure: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyFilledButton(
                          label: 'S I G N U P',
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              const Text('Already have an account?'),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
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
    );
  }
}
