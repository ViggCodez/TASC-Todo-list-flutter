import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Lottie.asset("assets/animations/1.json",
                reverse: true, repeat: true, fit: BoxFit.cover)),
        const Text(
          "Welcome to our to-do list app! ",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            "We're excited to help you stay organized and productive. Let's get started!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}
