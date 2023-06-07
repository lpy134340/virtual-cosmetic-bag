import 'package:beauty_habit_tracker/navigation_related/nav_menu_item.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});

  final NavMenuItem currentTab;
  final ValueChanged<NavMenuItem> onSelectTab;

  BottomNavigationBarItem _buildItem(NavMenuItem navMenuItem) {
    if (navMenuItem == NavMenuItem.home) {
      return BottomNavigationBarItem(
          icon: Icon(Icons.home, color: _colorTabMatching(navMenuItem)),
          label: navItemName[navMenuItem],
          backgroundColor: _colorTabMatching(navMenuItem));
    } else if (navMenuItem == NavMenuItem.products) {
      return BottomNavigationBarItem(
          icon: Icon(Icons.shop, color: _colorTabMatching(navMenuItem)),
          label: navItemName[navMenuItem],
          backgroundColor: _colorTabMatching(navMenuItem));
    } else if (navMenuItem == NavMenuItem.archivedProducts) {
      return BottomNavigationBarItem(
          icon: Icon(Icons.archive, color: _colorTabMatching(navMenuItem)),
          label: navItemName[navMenuItem],
          backgroundColor: _colorTabMatching(navMenuItem));
    }
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.mail,
          color: _colorTabMatching(navMenuItem),
        ),
        label: navItemName[navMenuItem],
        backgroundColor: _colorTabMatching(navMenuItem));
  }

  Color _colorTabMatching(NavMenuItem item) {
    Color color = Colors.grey;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.grey,
      items: [
        _buildItem(NavMenuItem.home),
        _buildItem(NavMenuItem.products),
        _buildItem(NavMenuItem.archivedProducts),
        _buildItem(NavMenuItem.inbox)
      ],
      onTap: (navmenuItem) => onSelectTab(
        NavMenuItem.values[navmenuItem],
      ),
    );
  }
}
