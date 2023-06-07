// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  Object? firstName;
  Object? lastName;
  Object? age;

  User({this.firstName, this.lastName, this.age});

  factory User.fromJson(Map<String, Object?> json) {
    return User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        age: json['age']);
  }
}

// Define a custom Form widget.
class UserInfoUpdateForm extends StatefulWidget {
  const UserInfoUpdateForm({super.key});

  @override
  UserInfoUpdateFormState createState() {
    return UserInfoUpdateFormState();
  }
}

class UserInfoUpdateFormState extends State<UserInfoUpdateForm> {
  final _userInfoformKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  int age = 0;
  late TextEditingController firstNameController =
      TextEditingController(text: firstName);
  late TextEditingController lastNameController =
      TextEditingController(text: lastName);
  late TextEditingController ageController =
      TextEditingController(text: age.toString());

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((userData) {
      setState(() {
        firstName = userData.data()!['firstName'];
        lastName = userData.data()!['lastName'];
        age = userData.data()!['age'];
        firstNameController = TextEditingController(text: firstName);
        lastNameController = TextEditingController(text: lastName);
        ageController = TextEditingController(text: age.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Form(
          key: _userInfoformKey,
          child: Column(
            children: <Widget>[
              Text(firstName),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'First name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Last name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Age')
                  // ignore: todo
                  //TODO: How to add validator for number?
                  ),
              ElevatedButton(
                  onPressed: () async {
                    if (_userInfoformKey.currentState!.validate()) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!
                              .uid) // use documentID here to update particular document
                          .update({
                        "firstName": firstNameController.text,
                        "lastName": lastNameController.text,
                        "age": int.parse(ageController.text),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Updated Data!'),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.of(context).pop(true);
                    }
                  },
                  // ignore: prefer_const_constructors
                  child: Text("Update"))
            ],
          ))
    ]);
  }
}
