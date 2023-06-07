// ignore_for_file: prefer_const_constructors
import 'package:beauty_habit_tracker/contact_and_futuretasks/terms.dart';
import 'package:beauty_habit_tracker/post_login/post_login_landing.dart';
import 'package:flutter/material.dart';
import 'social_media.dart';
import 'contact_form.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: ListView(
            children: <Widget>[
              IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                  semanticLabel: 'Back to home page',
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostLoginLanding()),
                    (Route<dynamic> route) => true,
                  );
                },
              ),
              ContactForm(),
              Terms(),
              SocialMedia(),
            ],
          ),
        ));
  }
}
