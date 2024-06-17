import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../custom widget/custom_elevated_button.dart';
import '../custom widget/patient_info.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color myColor = Colors.red;
  bool canEdit = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController weight = TextEditingController();

  void ProfilePic() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 90);

    Reference ref = await FirebaseStorage.instance
        .ref()
        .child("${PatientInfo.name}_profile.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        PatientInfo.profile_link = value;
      });

      await FirebaseFirestore.instance
          .collection('Users')
          .doc('${PatientInfo.email}')
          .update({'profilePic': PatientInfo.profile_link});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = PatientInfo.name!;
    email.text = PatientInfo.email!;
    phone.text = PatientInfo.phone!;
    weight.text = PatientInfo.weight!;
    password.text = PatientInfo.password!;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 0.98 * width,
                    height: height / 5.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/abc.gif'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: height / 15,
                    child: CircleAvatar(
                      radius: height / 11,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          ProfilePic();
                        },
                        child: CircleAvatar(
                          radius: height / 12,
                          child: PatientInfo.profile_link == null
                              ? Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 60,
                          )
                              : null,
                          backgroundImage: PatientInfo.profile_link != null
                              ? NetworkImage(PatientInfo.profile_link!)
                              : null,
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 14.5),
              Container(
                child: Text(
                  PatientInfo.name!,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: canEdit
                      ? [
                    TextsField("Name", "Enter your Name",
                        name, true),
                    TextsField("Email",
                        "Enter your Email", email, true),
                    TextsField("Phone",
                        "Enter your Phone", phone, true),
                    TextsField(
                        "Weight",
                        "Enter your weight",
                        weight,
                        true),
                    TextsField(
                        "Password",
                        "Enter your password.",
                        password,
                        true),
                  ]
                      : [
                    TextsField("Name", '', name, false),
                    TextsField(
                        "Email", '', email, false),
                    TextsField("Phone", "", phone, false),
                    TextsField(
                        "Weight", '', weight, false),
                    TextsField("Password", '',
                        password, false),
                  ]),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  height: height / 14,
                  width: width / 2.5,

                    child: CustomElevatedButton(

                        onPressed: () async {
                          setState(() {
                            canEdit = !canEdit;
                          });
                          if (name.text.isEmpty) {
                            showSnackBar('Please Enter your name!');
                          } else if (email.text.isEmpty) {
                            showSnackBar("Please Enter your email");
                          } else if (phone.text.isEmpty) {
                            showSnackBar("Please Enter your phone No");
                          } else {
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(PatientInfo.email)
                                .update({
                              'name': name.text,
                              'email': email.text,
                              'phone': phone.text,
                              'weight': weight.text,
                              'password': password.text,
                            });
                            PatientInfo.name =  name.text;
                            PatientInfo.email = email.text;
                            PatientInfo.phone = phone.text;
                            PatientInfo.weight = weight.text;
                            PatientInfo.password =
                          password.text;
                            print(PatientInfo.email);
                          }
                        },
                        child: Text(
                          canEdit != true ? 'Edit Profile' : 'Save',
                          style: TextStyle(fontSize: 15),
                        )),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
        )));
  }
}

class TextsField extends StatelessWidget {
  TextsField(this.fieldname, this.hint, this.controller, this.editingEnabled);
  final String fieldname;
  final String hint;
  final TextEditingController controller;
  final bool editingEnabled;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return Container(
      padding: EdgeInsets.only(
          right: width / 14, left: width / 14, top: height / 68),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldname,
            style: editingEnabled
                ? TextStyle(color: Colors.grey[900], fontSize: 15)
                : TextStyle(
                color: Colors.grey[900],
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(height: height / 136),
          SizedBox(
            height: height / 12.5,
            width: width / 1.12,
            child: editingEnabled
                ? TextField(
              readOnly: !editingEnabled,
              controller: controller,
              onChanged: (value) {},
              cursorColor: Colors.redAccent.withOpacity(0.8),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hint,
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.redAccent.withOpacity(0.8))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.redAccent.withOpacity(0.8)))),
            )
                : Container(
                padding: EdgeInsets.symmetric(
                    vertical: height / 40, horizontal: width / 40),
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Text(
                  controller.text,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                )),
          ),
          SizedBox(height: height / 70)
        ],
      ),
    );
  }
}