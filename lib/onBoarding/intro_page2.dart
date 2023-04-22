import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Lottie.asset("assets/animations/2.json",
                reverse: true, repeat: true, fit: BoxFit.cover)),
        const Text(
          "We're thrilled to have you on board.",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            " Our to-do list app is intuitive and easy to use, so you can focus on what's important and be efficient. ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}
