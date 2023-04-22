import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasc/db/db_helper.dart';
import 'package:tasc/onBoarding/onboarding_screen.dart';
import 'package:tasc/screens/home/home.dart';
import 'package:tasc/services/theme_services.dart';
import 'package:tasc/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent)); //statusbar ka color

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TASC',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isViewed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      function: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('onBoard')) {
          isViewed = prefs.getBool('onBoard') ?? false;
        } else {
          await prefs.setBool("onBoard", false);
        }
      },
      splash: Column(
        children: [
          Expanded(
              child: Image.asset(
            'assets/images/logo.png',
            height: 203.0,
            width: 203.0,
          )),
          Expanded(
            child: const Text(
              'TASC',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.orangeAccent,
      nextScreen: isViewed ? const HomePage() : const OnBoardingScreen(),
      splashIconSize: 350,
      duration: 100,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 1),
    );
  }
}

// //class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// //class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return isviewed != 1 ? const OnBoardingScreen() : const HomePage();
//   }
// }
