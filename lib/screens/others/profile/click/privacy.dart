import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          'Privacy',
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'At our to-do list app, we take your privacy very seriously. This Privacy Policy outlines the types of personal information we may collect and how we use that information.Information We Collect include the following. We collect personal information when you register an account with our app, such as your name and email address. We may also collect usage data, such as the tasks you add to your to-do list, and how frequently you use our app.We use your personal information to improve your experience with our app, such as by customizing your to-do list and providing personalized suggestions. We may also use your information to send you important app updates, promotions, and other communications.We do not sell your personal information to third parties. However, we may share your information with trusted partners who help us operate our app and provide customer support.We take appropriate measures to protect your personal information from unauthorized access, disclosure, or destruction. However, no internet or email transmission is ever fully secure or error-free.Changes to this Privacy Policy.We may update this Privacy Policy from time to time. If we make significant changes, we will notify you by email or by posting a notice on our website. '),
                  TextSpan(
                    text:
                        'Check more details or contact us on www.tascapp.com ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
