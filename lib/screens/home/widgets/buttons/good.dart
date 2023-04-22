import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreetingWidget extends StatelessWidget {
  final TextStyle _greetingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('jm');
    String formattedTime = formatter.format(now);
    String greeting;

    if (now.hour < 12) {
      greeting = 'Good Morning 🌞';
    } else if (now.hour < 18) {
      greeting = 'Good Afternoon 🌤️';
    } else {
      greeting = 'Good Night 🌜';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: _greetingStyle,
          ),
          SizedBox(height: 4),
          Text(
            'It\'s currently $formattedTime',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
