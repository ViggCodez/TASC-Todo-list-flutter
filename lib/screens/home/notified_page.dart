import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
            onPressed: (() => Get.back()),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        title: Text(
          this.label.toString().split("|")[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
          // textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.white : Colors.grey[400],
          ),
          child: Center(
            child: Text(
              "Note : " + this.label.toString().split("|")[1],
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                  fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
