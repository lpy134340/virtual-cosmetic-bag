import 'package:beauty_habit_tracker/post_login/post_login_landing.dart';
import 'package:beauty_habit_tracker/pre_login/pre_login_home.dart';
import 'package:beauty_habit_tracker/user_related/reset_password.dart';
import 'package:flutter/material.dart';

import 'popup_dialog_sign_in.dart';
import '../services/auth_service.dart';
import '../utils/button_factory.dart';

const loginPageTitle = "Log in";
const loginWelcomeMsg = 'We are happy to see your here :)';
const topEdgeSize = 80.0;
const titleFontSize = 32.0;
const bodyFontSize = 20.0;
const buttonSize =
    MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 35));
/*
class FormData {
  String? email;
  String? password;

  FormData({
    this.email,
    this.password,
  });
}
*/

class LogInEmail extends StatefulWidget {
  const LogInEmail({super.key});

  @override
  State<LogInEmail> createState() => _LogInEmailState();
}

class _LogInEmailState extends State<LogInEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool notSignedIn = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      final String text = emailController.text;
      emailController.value = emailController.value.copyWith(text: text);
    });
    passController.addListener(() {
      final String text = passController.text;
      passController.value = passController.value.copyWith(text: text);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.1;
    //FormData formData = FormData(email: "", password: "");

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(loginPageTitle,
                        semanticsLabel: loginPageTitle,
                        style: TextStyle(fontSize: titleFontSize)),
                  ),
                  const SizedBox(height: 20),
                  // welcome msg
                  const Center(
                    child: Text(loginWelcomeMsg,
                        semanticsLabel: loginWelcomeMsg,
                        style: TextStyle(fontSize: bodyFontSize)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofocus: true,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Your email address',
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      //formData.email = emailController.text;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: passController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      //formData.password = passController.text;
                    },
                  ),
                  SizedBox(height: width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SizedBox(width: width * 0.10),
                      const Text("Forget your password?",
                          semanticsLabel: 'Forget your password?'),
                      //SizedBox(width: width * 1),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onPressed: () {
                            // push to reset password
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()),
                            );
                          },
                          child: const Text('Reset',
                              semanticsLabel: 'Reset password')),
                    ],
                  ),
                  SizedBox(height: width),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // cancel button
                        //SizedBox(width: width * 0.10),
                        ProjectButton.primary(
                          semanticsLabel: 'Cancel',
                          label: 'Cancel',
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                              padding: buttonSize),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                            );
                          },
                        ),

                        // seperator
                        //SizedBox(width: width * 1.5),

                        // submit button
                        ProjectButton.primary(
                            semanticsLabel: 'Submit',
                            label: 'Submit',
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.green),
                                padding: buttonSize),
                            onPressed: () async {
                              final snackBar = SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Row(
                                  children: const <Widget>[
                                    CircularProgressIndicator(),
                                    Text("  Signing in...")
                                  ],
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              try {
                                AuthService service = AuthService();
                                await service.signIn(
                                    emailController.text, passController.text);
                                notSignedIn = false;
                              } catch (e) {
                                PopupDialog errDialog =
                                    PopupDialog(errMsg: e.toString());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        errDialog);
                                notSignedIn = true;
                              }
                              if (!notSignedIn) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PostLoginLanding()),
                                  );
                                });
                              }
                            })
                      ])
                ])));
  }
}
