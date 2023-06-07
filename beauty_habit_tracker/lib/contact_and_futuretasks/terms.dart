import 'dart:core';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const double headingSize = 20.0;
const double contentSize = 15.0;
const sizedBox = SizedBox(height: 30.0);

class Terms extends StatelessWidget {
  Terms({super.key});
  final Uri urlprivacy = Uri.parse(
      'https://docs.google.com/document/d/1QBDGupHNUtkshTIlxGzNr0kxgZpgXgqT2TUVzd8R02o/edit?usp=sharing');

  final Uri urltermofuse = Uri.parse(
      'https://docs.google.com/document/d/1k_uLmZ87p2-buhprAAWV2Cj0_6c2EyvXoD182jIzYbI/edit?usp=sharing');

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text(
        "Term of use",
        style: TextStyle(
          fontSize: headingSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      sizedBox,
      const Text(
        "Beauty Habit Tracker (“Licensed Application”) is a piece of software created to help consumers manage their beauty products and habits.",
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: contentSize,
          fontWeight: FontWeight.normal,
        ),
      ),
      TextButton(
        child: const Text(
          "<Read More>",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: contentSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () async {
          _launchUrl(urltermofuse);
        },
      ),
      sizedBox,
      const Text(
        "Privacy Terms",
        style: TextStyle(
          fontSize: headingSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      sizedBox,
      TextButton(
        child: const Text(
          "<Read More>",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: contentSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () async {
          _launchUrl(urlprivacy);
        },
      ),
      sizedBox,
    ]);
  }
}
