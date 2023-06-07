import 'package:flutter/material.dart';

enum NavMenuItem { home, products, archivedProducts, inbox }

const Map<NavMenuItem, String> navItemName = {
  NavMenuItem.home: 'Home',
  NavMenuItem.products: 'Products',
  NavMenuItem.archivedProducts: 'Archived',
  NavMenuItem.inbox: 'Inbox',
};

const Map<NavMenuItem, Color> activeTabColor = {
  NavMenuItem.home: Colors.blue,
  NavMenuItem.products: Colors.blue,
  NavMenuItem.archivedProducts: Colors.blue,
  NavMenuItem.inbox: Colors.blue,
};
