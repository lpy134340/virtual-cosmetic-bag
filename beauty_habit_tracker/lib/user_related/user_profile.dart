// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../navigation_related/sidebar.dart';
import 'user_info.dart';

const double buttonWidth = 200;
const double buttonHeight = 50;
const Color buttonColor_1 = Colors.blue;
const Color buttonColor_2 = Colors.black;
const double topMargin = 25;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white),
      drawer: const SideBar(),
      body: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Expanded(child: UserInfo()),
              const SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                const SizedBox(height: 20),
                SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        // <-- Icon
                        Icons.graphic_eq,
                        size: 24.0,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              buttonColor_2 //elevated btton background color
                          ),
                      label: const Text(
                          semanticsLabel: "Tap to View Habit Data",
                          'View Habit data',
                          textAlign: TextAlign.center), // <-- Text
                    )),
                const SizedBox(height: topMargin),
                SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          // <-- Icon
                          Icons.wallet_giftcard,
                          size: 24.0,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                buttonColor_2 //elevated btton background color
                            ),
                        label: const Text(
                            semanticsLabel: "Tap to View Membership Benefits",
                            'Membership Benefits',
                            textAlign: TextAlign.center))),
                const SizedBox(height: topMargin),
                SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        // <-- Icon
                        Icons.settings,
                        size: 24.0,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              buttonColor_2 //elevated btton background color
                          ),
                      label: const Text(
                        semanticsLabel: "Tap to View Settings",
                        'Settings',
                        textAlign: TextAlign.center,
                      ), // <-- Text
                    )),
              ])),
            ],
          )),
    );
  }
}
