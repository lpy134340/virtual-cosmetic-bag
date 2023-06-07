// ignore_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'package:beauty_habit_tracker/products/archived_products.dart';
import 'package:beauty_habit_tracker/contact_and_futuretasks/inbox.dart';
import 'package:beauty_habit_tracker/post_login/post_login_home.dart';
import 'package:beauty_habit_tracker/products/products.dart';
import 'package:flutter/material.dart';

import 'package:beauty_habit_tracker/navigation_related/nav_menu_item.dart';

class MenuTabNavigatorRoutes {
  static const String root = '/';
  static const String products = '/products';
}

class MenuTabNavigator extends StatelessWidget {
  const MenuTabNavigator({
    super.key,
    required this.navigatorKey,
    required this.tabItem,
  });
  final GlobalKey<NavigatorState> navigatorKey;
  final NavMenuItem tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == NavMenuItem.home) {
      child = PostLoginHome();
    } else if (tabItem == NavMenuItem.products) {
      child = Products();
    } else if (tabItem == NavMenuItem.archivedProducts) {
      child = ArchivedProducts();
    } else {
      child = Inbox();
    }
    return Navigator(
      key: navigatorKey,
      initialRoute: MenuTabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}
