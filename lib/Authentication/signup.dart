import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healme/Screens/home_screen.dart';
import 'login_screen.dart';
import '../custom widget/custom_elevated_button.dart';
import '../custom widget/custom_text_button.dart';
import '../custom widget/patient_info.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  bool _passwordIsObscured = true;
  bool _confirmPasswordIsObscured = true;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

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
                      'Sign Up',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter your details and create an account:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Your Name *',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
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
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Your Phone No. *',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
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
                        labelText: 'Choose a Password *',
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
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: _confirmPasswordIsObscured,
                      controller: confirmPassword,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password *',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            setState(() => _confirmPasswordIsObscured =
                            !_confirmPasswordIsObscured),
                          },
                          icon: Icon(
                            _confirmPasswordIsObscured
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: weight,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Your weight *',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: age,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyMedium,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: 'Your Age',
                              labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            style: Theme.of(context).textTheme.bodyMedium,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: 'Gender *',
                              labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                            items: const [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text('Male'),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text('Female'),
                              ),
                            ],
                            onChanged: (value) {
                              // Handle gender selection
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      onPressed: () async {
                        if (name.text.isEmpty ||
                            email.text.isEmpty ||
                            phone.text.isEmpty ||
                            password.text.isEmpty ||
                            confirmPassword.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                              Text("Fill all the * necessary fields")));
                        } else if (!EmailValidator.validate(email.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Email address is invalid!")));
                        } else if (password.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Password should be atleast 6 characters")));
                        } else if (password.text != confirmPassword.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Passwords do not match")));
                        } else {
                          try {
                            final user = await _auth
                                .createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.user!.uid)
                                .set({
                              'name': name.text,
                              'email': email.text,
                              'phone': phone.text,
                              'age': age.text,
                              'weight': weight.text,
                            });

                            PatientInfo.name = name.text;
                            PatientInfo.weight = weight.text;
                            PatientInfo.phone = phone.text;
                            // PatientInfo.age = age.text;
                            PatientInfo.email = email.text;
                            PatientInfo.password = password.text;

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Data submitted")));


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homescreen()),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Sign up failed: $e")));
                          }
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 20.00),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextButton(
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        ),
                      },
                      title: 'Already have an account? Sign In here',
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
