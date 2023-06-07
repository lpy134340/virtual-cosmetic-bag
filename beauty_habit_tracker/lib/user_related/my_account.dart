import 'package:beauty_habit_tracker/navigation_related/sidebar.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});
  // final String title;

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("My Account"),
          iconTheme: const IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white),
      drawer: const SideBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text("My Account"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
