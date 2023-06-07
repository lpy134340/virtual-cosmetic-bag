import 'package:beauty_habit_tracker/utils/button_factory.dart';
import 'package:beauty_habit_tracker/user_related/log_in_email.dart';
import 'package:beauty_habit_tracker/pre_login/pre_login_home.dart';
import 'package:flutter/material.dart';

const loginPageTitle = "Log in";
const loginWelcomeMsg = "We are happy to see you here :)";
const titleFontSize = 32.0;
const bodyFontSize = 20.0;
const emailLabel = 'Continue with Email';
const appleLabel = 'Continue with Apple';
const googleLabel = 'Continue with Google';
const cancelLabel = 'Cancel';
const buttonSize =
    MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 70));
const gapSize = 20.0;
const topEdgeSize = 120.0;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        // title
        Container(
          margin: const EdgeInsets.only(top: topEdgeSize),
          child: const Text(loginPageTitle,
              semanticsLabel: loginPageTitle,
              style: TextStyle(fontSize: titleFontSize)),
        ),

        // welcome msg
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: const Text(loginWelcomeMsg,
              semanticsLabel: loginWelcomeMsg,
              style: TextStyle(fontSize: bodyFontSize)),
        ),

        // email log-in button
        Container(
            margin: const EdgeInsets.only(top: 45),
            child: ProjectButton.primary(
              semanticsLabel: emailLabel,
              label: emailLabel,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                  padding: buttonSize),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInEmail()),
                );
              },
            )),

        // line divider
        Container(
            margin: const EdgeInsets.only(top: 15),
            child: const Divider(
              height: 20,
              thickness: 1,
              indent: 80,
              endIndent: 80,
              color: Colors.black,
            )),

        // more log-in buttons
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text('or',
              semanticsLabel: 'or', style: TextStyle(fontSize: bodyFontSize)),
        ),

        // apple
        Container(
            margin: const EdgeInsets.only(top: gapSize),
            child: ProjectButton.primary(
              semanticsLabel: appleLabel,
              label: appleLabel,
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                  padding: buttonSize),
              onPressed: () {},
            )),

        // google
        Container(
            margin: const EdgeInsets.only(top: gapSize),
            child: ProjectButton.primary(
              semanticsLabel: googleLabel,
              label: googleLabel,
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                  padding: buttonSize),
              onPressed: () {},
            )),

        //cancel
        Container(
            margin: const EdgeInsets.only(top: gapSize),
            child: ProjectButton.primary(
              label: cancelLabel,
              semanticsLabel: cancelLabel,
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.black),
                  padding: MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 120))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ))
      ],
    )));
  }
}
