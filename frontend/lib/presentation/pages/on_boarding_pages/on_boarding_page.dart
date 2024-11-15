import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/onboarding_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/get_started_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  OnBoardingController _pageController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((value) {
      _pageController.pageController.addListener(() {
        _pageController.currentPage =
            _pageController.pageController.page!.round();
        if ((_pageController.currentPage == 2 ||
                _pageController.currentPage == 1) &&
            _pageController.currentPage != _pageController.lastPage) {
          print(_pageController.pageController.page);
          _pageController.update();

          _pageController.lastPage = _pageController.currentPage;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<OnBoardingController>(
          builder: (controller) => Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: size.height,
                child: PageView(
                  controller: _pageController.pageController,
                  children:  [
                    const OnBoardingOne(),
                    const OnBoardingTwo(),
                    GetStartedPage(),
                  ],
                ),
              ),
              Positioned(
                top: size.height * .85,
                width: size.width - 40,
                child: AnimatedOpacity(
                  opacity: _pageController.currentPage != 2 ? 1 : 0,
                  duration: Durations.long3,
                  
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        effect: const ExpandingDotsEffect(
                            dotColor: Colors.white,
                            activeDotColor: Colors.white,
                            dotHeight: 8,
                            dotWidth: 8),
                        controller: _pageController.pageController,
                        count: 3,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              _pageController.pageController.animateToPage(
                                3,
                                duration: Durations.long4,
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Skip',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _pageController.pageController.nextPage(
                                duration: Durations.long4,
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
