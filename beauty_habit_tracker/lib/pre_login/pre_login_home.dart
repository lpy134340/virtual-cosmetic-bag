import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import '../user_related/log_in.dart';
import '../user_related/sign_up.dart';

const videoLink =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
const appWelcomeMsg = "Welcome to Beauty Habit Tracker";
const appGreetingMsg = "We are happy to see you here :)";
const appDescription = """
Track product expiration dates, be reminded with reflls, build your using habits and help save the environment. Want to learn more?""";
const appActionMsg = "Check out the video below";
const appTitleFontSize = 32.0;
const appBodyFontSize = 20.0;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(videoLink);
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.1;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(60.0),
      child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: <Widget>[
            const Text(appWelcomeMsg,
                semanticsLabel: appWelcomeMsg,
                style: TextStyle(fontSize: appTitleFontSize)),
            const SizedBox(height: 20),
            const Text(appGreetingMsg,
                semanticsLabel: appGreetingMsg,
                style: TextStyle(fontSize: appBodyFontSize)),
            const SizedBox(height: 40),
            const Text(appDescription,
                semanticsLabel: appDescription,
                style: TextStyle(fontSize: appBodyFontSize)),
            const SizedBox(height: 20),
            const Text(appActionMsg,
                semanticsLabel: appActionMsg,
                style: TextStyle(fontSize: appBodyFontSize)),
            const SizedBox(height: 20),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),

            // the video player button
            FloatingActionButton.small(
              onPressed: () {
                setState(() {
                  // pause
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // play
                    _controller.play();
                  }
                });
              },
              // icon
              child: Icon(
                semanticLabel: 'Play video',
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: width),
                  ),
                  child: const Text('Log in', semanticsLabel: 'Log in'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogIn()),
                    );
                  }),
              SizedBox(width: width),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: width),
                  ),
                  child: const Text('Sign up', semanticsLabel: 'Sign up'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  }),
            ]),
          ]),
    ));
  }
}
