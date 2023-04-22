import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasc/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareApp extends StatelessWidget {
  const ShareApp({Key? key}) : super(key: key);

  void _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.google.android.youtube';
    //'https://play.google.com/store/apps/details?id=com.example.tasc';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Share this app with your friends and family',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(preprimClr),
              ),
              onPressed: _launchURL,
              child: const Text('Share App'),
            ),
          ],
        ),
      ),
    );
  }
}
