import 'package:flutter/material.dart';

const double iconSize = 40.0;
const Color rateColor = Colors.yellow;
const Color facebookColor = Colors.blue;
const Color tiktokColor = Colors.red;

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {
              //todo: implement ratemyapp function
              //_rateMyApp();
            },
            iconSize: iconSize,
            icon: const Icon(Icons.star),
            color: rateColor,
          ),
          IconButton(
              onPressed: () {
                //todo: implement linktoFacebook function
                //_linkFacebook();
              },
              iconSize: iconSize,
              icon: const Icon(Icons.facebook),
              color: facebookColor),
          IconButton(
              onPressed: () {
                //todo: implement followTikTokfunction
                //_routetotiktok();
              },
              iconSize: iconSize,
              icon: const Icon(Icons.tiktok),
              color: tiktokColor),
        ]);
  }
}
