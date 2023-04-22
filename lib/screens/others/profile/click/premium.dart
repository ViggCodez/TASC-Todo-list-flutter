import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasc/theme/theme.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          'Go premium',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pre.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  left: 20,
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Currently we are working on that feature',
                            style: TextStyle(
                                color: redClr, fontWeight: FontWeight.bold),
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    child: Text(
                      'Upgrade Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      onPrimary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Features',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.green),
                  title: Text('Ad-free experience'),
                ),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.green),
                  title: Text('Unlimited access to all features'),
                ),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.green),
                  title: Text('More Themes'),
                ),
                SizedBox(height: 20),
                Text(
                  'Pricing',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Get access to all premium features for just \₹100/month',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
