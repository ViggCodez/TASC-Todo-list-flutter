import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasc/auth/firebase_auth.dart';
import 'package:tasc/auth/forgetpass.dart';
import 'package:tasc/screens/home/home.dart';
import '../theme/theme.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void navigateToRegister() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SignupScreen()),
    // );
    Get.to(SignupScreen(), transition: Transition.fade);
  }

  void navigateToResetPass() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SignupScreen()),
    // );
    Get.to(SignupScreen(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log In'),
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          automaticallyImplyLeading: false, // Removes back button
        ),
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back User!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          Get.to(ForgetPasswordPage());
                        },
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.blueGrey[900],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //  Perform login logic here
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              // User is signed in successfully
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                                // Show error message to the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('No user found for that email.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                // Show error message to the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Wrong password provided for that user.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            }

                            await AuthHelper.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                            if (AuthHelper.isUserSignedIn) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool("onBoard", true);
                              print(AuthHelper.user?.displayName);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            }
                          }
                        },
                        child: const Text('Log In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                              238, 139, 96, 1.0), // #EE8B60
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: navigateToRegister,
                        child: const Text('Don\'t have an account? Sign up'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromRGBO(
                              238, 139, 96, 1.0), // #EE8B60
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
