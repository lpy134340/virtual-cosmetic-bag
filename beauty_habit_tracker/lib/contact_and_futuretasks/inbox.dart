import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      SizedBox(height: 50),
      Center(
        child: Text(
          "Inbox: Coming Soon...",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ]);
  }
}
