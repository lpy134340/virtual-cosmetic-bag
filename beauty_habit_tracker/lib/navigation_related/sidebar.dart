import 'package:beauty_habit_tracker/post_login/post_login_landing.dart';
import 'package:beauty_habit_tracker/pre_login/pre_login_home.dart';
import 'package:beauty_habit_tracker/contact_and_futuretasks/contact_us.dart';
import 'package:beauty_habit_tracker/contact_and_futuretasks/help.dart';
import 'package:beauty_habit_tracker/user_related/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(''),
        ),
        ListTile(
          autofocus: true,
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PostLoginLanding()),
            );
          },
        ),
        ListTile(
          autofocus: true,
          leading: const Icon(Icons.person),
          title: const Text("My Account"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const UserProfile()));
          },
        ),
        ListTile(
          autofocus: true,
          leading: const Icon(Icons.contact_phone),
          title: const Text("Contact Us"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const ContactUsPage()));
          },
        ),
        ListTile(
          autofocus: true,
          leading: const Icon(Icons.help),
          title: const Text("Help"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const HelpPage()));
          },
        ),
        ListTile(
          autofocus: true,
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        ),
      ],
    ));
  }
}
