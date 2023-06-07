import 'package:beauty_habit_tracker/post_login/post_login_landing.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(
        'https://docs.google.com/document/d/1Q9fo-EbB1nh0lprXVGL1VThvWhGUNmolWOU6LRTTp2o/edit?usp=sharing');
    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  children: [
                    IconButton(
                      alignment: Alignment.topLeft,
                      icon: const Icon(
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
                    const Text(
                      "Help",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30, width: 50)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text(
                  'Terminologies used across our application:',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: 600,
                  width: 400,
                  child: ListView(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'PD',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'Purchase date: the date that the consumer purchases the product (includes the order date of an online purchase.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'OD',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'Open date: the date that the consumer unsealed the product.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'EXD',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'Expiration Date: The date that the product will expire and should not be used anymore. Usually, this date must be specified only for products whose shelf life period is 30 months or less. If this date is present, it should be printed directly on the product package; for example, Exp. 09/25/2025 means that makeup can be used only before 25 September 2025.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'PAO',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: const Text(
                          'Period after opening: usually, on the beauty product package, there is an “open jar” sign with a number followed by the letter M, where the number indicates how many months the product can be safely used after opening. For example, 6M means that the product can be used for six months after opening; 12M means that the product can be used for twelve months after you open it, etc.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 300,
                child: ElevatedButton(
                  child: const Text('More Info'),
                  onPressed: () async {
                    _launchUrl();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class QuestionAndAnswer extends StatelessWidget {
  const QuestionAndAnswer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
