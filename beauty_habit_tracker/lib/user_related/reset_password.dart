// ignore_for_file: avoid_print
import 'package:beauty_habit_tracker/pre_login/pre_login_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/button_factory.dart';

const pageTitle = 'Reset password';
const welcomeMsg =
    'Please enter your email address. A message will be sent with instructions to reset your password';
const topEdgeSize = 120.0;
const titleFontSize = 32.0;
const bodyFontSize = 15.0;
const buttonSize =
    MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 35));

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController controller = TextEditingController();
  String email = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.1;
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          // title
          Container(
            margin: const EdgeInsets.only(top: topEdgeSize),
            child: const Text(pageTitle,
                semanticsLabel: pageTitle,
                style: TextStyle(fontSize: titleFontSize)),
          ),

          // welcome msg
          Container(
            margin: const EdgeInsets.only(left: 50, right: 40, top: 50),
            child: const Text(welcomeMsg,
                semanticsLabel: welcomeMsg,
                style: TextStyle(fontSize: bodyFontSize)),
          ),

          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
              onChanged: (value) {
                email = value;
                //
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width, right: width, top: 160),
            child: Row(
              children: [
                // cancel button
                ProjectButton.primary(
                  semanticsLabel: 'Cancel',
                  label: 'Cancel',
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black),
                      padding: buttonSize),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                // seperator
                SizedBox(width: width + 35),

                // submit button
                ProjectButton.primary(
                    semanticsLabel: 'Submit',
                    label: 'Submit',
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green),
                        padding: buttonSize),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email);
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        print(e.message);
                      }
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    })
              ],
            ),
          ),
        ],
      )),
    );
  }
}

// this is not refactored as it has different fields and page routing
Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Reset email sent!', semanticsLabel: 'Reset email sent!'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ));
        },
        child: const Text('Close', semanticsLabel: 'Close'),
      ),
    ],
  );
}
