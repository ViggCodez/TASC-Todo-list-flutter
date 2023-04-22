import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Lottie.asset("assets/animations/3.json",
                height: 350, reverse: true, repeat: true, fit: BoxFit.cover)),
        const Text(
          "Let's set up your account!",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            "We're here to make your life easier by helping you keep track of all your tasks so you can complete it on time.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
