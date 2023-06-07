import 'package:beauty_habit_tracker/navigation_related/bottom_navigation.dart';
import 'package:beauty_habit_tracker/navigation_related/menu_tab_navigator.dart';
import 'package:beauty_habit_tracker/navigation_related/nav_menu_item.dart';
import 'package:flutter/material.dart';
import '../navigation_related/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostLoginLanding extends StatefulWidget {
  const PostLoginLanding({super.key});

  @override
  State<PostLoginLanding> createState() => _PostLoginLandingState();
}

class _PostLoginLandingState extends State<PostLoginLanding> {
  var _currentTab = NavMenuItem.home;
  String _userName = '';

  final _navigatorKeys = {
    NavMenuItem.home: GlobalKey<NavigatorState>(),
    NavMenuItem.products: GlobalKey<NavigatorState>(),
    NavMenuItem.archivedProducts: GlobalKey<NavigatorState>(),
    NavMenuItem.inbox: GlobalKey<NavigatorState>(),
  };

  void _selectTab(NavMenuItem tabItem) {
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future getUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      setState() {
        _userName = user.data()!['firstName'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          iconTheme: const IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white),
      drawer: const SideBar(),
      body: MenuTabNavigator(
        navigatorKey: _navigatorKeys[_currentTab]!,
        tabItem: _currentTab,
      ),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }
}
