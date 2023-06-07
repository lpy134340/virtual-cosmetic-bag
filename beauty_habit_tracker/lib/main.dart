// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pre_login/pre_login_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "beauty-habit-tracker",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var status = await Permission.photos.status;
  if (status != PermissionStatus.granted) {
    print(status.toString());
  }
  if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    openAppSettings();
    // print(statuses[Permission.location]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

@override
State<MyHomePage> createState() => _MyHomePageState();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white),
    );
  }
}
