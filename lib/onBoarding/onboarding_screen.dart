import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasc/onBoarding/intro_page1.dart';
import 'package:tasc/onBoarding/intro_page2.dart';
import 'package:tasc/onBoarding/intro_page3.dart';
import '../auth/register.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //controllet to keep track of which page we on
  final PageController _controller = PageController();

  //keep track of if we are on last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //page view
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),
        //dot indicator
        Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //skip

              GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text(
                    "SKIP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),

              //dot indicator
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.teal.shade700),
              ),

              //next or done
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignupScreen();
                        }));
                      },
                      child: const Text(
                        "DONE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
            ],
          ),
        ),
      ]),
    );
  }
}
