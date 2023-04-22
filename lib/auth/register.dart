import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasc/auth/firebase_auth.dart';
import 'package:tasc/screens/home/home.dart';
import '../theme/theme.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void navigateToLoginScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    // );
    Get.to(LoginScreen(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Sign Up'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                'Create a new account',
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //  Perform sign up logic here
                          await AuthHelper.createUserWithEmailAndPassword(
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
                      child: const Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(238, 139, 96, 1.0), // #EE8B60
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: navigateToLoginScreen,
                      child: const Text('Already have an account? Log in'),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromRGBO(238, 139, 96, 1.0), // #EE8B60
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
