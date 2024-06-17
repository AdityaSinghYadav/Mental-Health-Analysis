import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healme/Authentication/reset_password.dart';
import 'package:healme/Authentication/signup.dart';

import '../Screens/home_screen.dart';

import '../custom widget/custom_elevated_button.dart';
import '../custom widget/custom_text_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;

  bool _passwordIsObscured = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CustomTextButton(
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    padding: const EdgeInsets.all(6.0),
                    icon: Icons.arrow_back,
                    borderRadius: 50,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter your details to sign in:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Email Address *',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: _passwordIsObscured,
                      controller: password,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Password *',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            setState(() =>
                            _passwordIsObscured = !_passwordIsObscured),
                          },
                          icon: Icon(
                            _passwordIsObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),


                    const SizedBox(height: 10),
                    CustomTextButton(
                      padding: EdgeInsets.only(left:204),
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ResetScreen(),
                          ),
                        ),
                      },
                      title: 'Forgot Password',
                    ),




                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      onPressed: () async {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                              Text("Fill all the * necessary fields")));
                        } else if (!EmailValidator.validate(email.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Email address is invalid!")));
                        } else {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                            if (user != null) {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                    builder: (context) => Homescreen()),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Sign in failed: $e")));
                          }
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 20.00),
                      ),
                    ),


                    const SizedBox(height: 10),
                    CustomTextButton(
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        ),
                      },
                      title: 'Don\'t have an account? Sign Up here',
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
