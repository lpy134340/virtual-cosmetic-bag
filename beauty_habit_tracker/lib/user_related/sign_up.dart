import 'package:beauty_habit_tracker/post_login/post_login_landing.dart';
import 'package:beauty_habit_tracker/pre_login/pre_login_home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/button_factory.dart';
import 'handle_sign_up.dart';
import 'log_in_email.dart';

const topEdgeSize = 85.0;
const titleFontSize = 28.0;
const bodyFontSize = 20.0;
String regEx =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

const List<Widget> skinTypes = <Widget>[
  Text('Dry'),
  Text('Mixed'),
  Text('Oil')
];

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final List<bool> _selectedSkinTypes = <bool>[true, false, false];
  bool vertical = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(() {
      final String text = firstNameController.text;
      firstNameController.value =
          firstNameController.value.copyWith(text: text);
    });
    lastNameController.addListener(() {
      final String text = lastNameController.text;
      lastNameController.value = lastNameController.value.copyWith(text: text);
    });
    emailController.addListener(() {
      final String text = emailController.text;
      emailController.value = emailController.value.copyWith(text: text);
    });
    passwordController.addListener(() {
      final String text = passwordController.text;
      passwordController.value = passwordController.value.copyWith(text: text);
    });
    confirmPasswordController.addListener(() {
      final String text = confirmPasswordController.text;
      confirmPasswordController.value =
          confirmPasswordController.value.copyWith(text: text);
    });
    ageController.addListener(() {
      final String text = ageController.text;
      ageController.value = ageController.value.copyWith(text: text);
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    super.dispose();
  }

  String getSkinType(List<bool> selectedSkinTypes) {
    if (selectedSkinTypes[0]) {
      return 'Dry';
    }
    if (selectedSkinTypes[1]) {
      return 'Mixed';
    } else {
      return 'Oil';
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    double width = MediaQuery.of(context).size.width * 0.1;
    bool signUpSuccess = false;
    bool allFill = false;
    bool passwordMatch = false;
    bool ageOk = false;
    bool emailValid = false;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.black;
    }

    return Scaffold(
        key: scaffoldKey,
        body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: ListView(
                //keyboardDismissBehavior:
                //ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // title
                        const Text('Sign up',
                            semanticsLabel: 'Sign up',
                            style: TextStyle(fontSize: titleFontSize)),
                        const SizedBox(height: 20),
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'First Name',
                          ),
                          onChanged: (value) {
                            newUser.firstName = firstNameController.text;
                          },
                        ),
                        TextFormField(
                          controller: lastNameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Last Name',
                          ),
                          onChanged: (value) {
                            newUser.lastName = lastNameController.text;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Your email address',
                            labelText: 'Email',
                          ),
                          onChanged: (value) {
                            newUser.email = emailController.text;
                          },
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              filled: true,
                              labelText: 'Password',
                              hintText: 'Must be more than 6 characters long'),
                          onChanged: (value) {
                            newUser.password = passwordController.text;
                          },
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Confirm Password',
                            hintText: 'Must match the one you entered',
                          ),
                          onChanged: (value) {},
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: ageController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'You must be 18+ to use the app',
                            labelText: 'Age',
                          ),
                          onChanged: (value) {
                            newUser.age = num.tryParse(value) as int?;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.only(right: width + 200),
                            child: const Text('Skin Type',
                                semanticsLabel: 'Skin type',
                                style: TextStyle(fontSize: 16))),
                        const SizedBox(height: 20),
                        ToggleButtons(
                          direction: vertical ? Axis.vertical : Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              for (int i = 0;
                                  i < _selectedSkinTypes.length;
                                  i++) {
                                _selectedSkinTypes[i] = i == index;
                                newUser.skinType =
                                    getSkinType(_selectedSkinTypes);
                              }
                            });
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor: Colors.blue[700],
                          selectedColor: Colors.black,
                          fillColor: Colors.blue[200],
                          color: Colors.blue[400],
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.05,
                            minWidth: MediaQuery.of(context).size.width * 0.25,
                          ),
                          isSelected: _selectedSkinTypes,
                          children: skinTypes,
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          SizedBox(width: width * 0.15),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Terms',
                                  semanticsLabel: 'Terms and conditions',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrlString(
                                          'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: width),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text(
                            'Agree',
                            semanticsLabel: 'Agree to terms and conditions',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ]),
                        Row(children: [
                          // cancel button
                          ProjectButton.primary(
                            semanticsLabel: 'Cancel',
                            label: 'Cancel',
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.black),
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
                          const SizedBox(width: 90),

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
                                var snackBar = SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Row(
                                    children: const <Widget>[
                                      CircularProgressIndicator(),
                                      Text("  Signing Up...",
                                          semanticsLabel: 'Signing up')
                                    ],
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                if (firstNameController.value.text.isEmpty ||
                                    lastNameController.value.text.isEmpty ||
                                    emailController.value.text.isEmpty ||
                                    passwordController.value.text.isEmpty ||
                                    confirmPasswordController
                                        .value.text.isEmpty ||
                                    ageController.value.text.isEmpty) {
                                  const snackBar = SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                        "You need to fill all the info to sign up.",
                                        semanticsLabel:
                                            'You need to fill all the info to sign up'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  allFill = false;
                                } else {
                                  allFill = true;
                                  if (!RegExp(regEx)
                                      .hasMatch(emailController.value.text)) {
                                    snackBar = const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text("Invalid email address!",
                                          semanticsLabel:
                                              'Invalid email address!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    emailValid = false;
                                  } else {
                                    emailValid = true;
                                  }
                                  if (passwordController.value.text !=
                                      confirmPasswordController.value.text) {
                                    const snackBar = SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          "Password does not match. Please re-type again.",
                                          semanticsLabel:
                                              'Password does not maytch. Please re-type again.'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    passwordMatch = false;
                                  } else {
                                    passwordMatch = true;
                                  }

                                  if (newUser.age! < 18) {
                                    const snackBar = SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          "You need to be over 18 to sign up.",
                                          semanticsLabel:
                                              'You need to be over 18 to sign up'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    ageOk = false;
                                  } else {
                                    ageOk = true;
                                  }
                                  if (!isChecked) {
                                    const snackBar = SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          "You need to agree to the terms to sign up.",
                                          semanticsLabel:
                                              'You need to agree to the terms to sign up'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    isChecked = false;
                                  } else {
                                    isChecked = true;
                                  }
                                  if (allFill &&
                                      passwordMatch &&
                                      ageOk &&
                                      isChecked &&
                                      emailValid) {
                                    try {
                                      await handleSignUp();
                                      signUpSuccess = true;
                                    } catch (e) {
                                      snackBar = SnackBar(
                                        content: Text(e.toString()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      signUpSuccess = false;
                                    }
                                    if (signUpSuccess) {
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PostLoginLanding()),
                                        );
                                      });
                                    }
                                  }
                                }
                              })
                        ])
                      ])
                ])));
  }
}
