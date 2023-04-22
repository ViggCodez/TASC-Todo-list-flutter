// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasc/auth/login.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () async {
          await _auth.signOut();
          Get.offAll(LoginScreen());
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const LoginScreen(),
          //   ),
          // );
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(238, 139, 96, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
