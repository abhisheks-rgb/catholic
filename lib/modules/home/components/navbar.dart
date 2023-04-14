import 'package:flutter/material.dart';

import '../models/home_model.dart';

import '../../../app/app.dart';
import '../../../utils/asset_path.dart';

class Navbar extends StatelessWidget {
  final HomeModel? model;
  final String? routeName;

  const Navbar({
    super.key,
    this.model,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('home.png'),
                  color: const Color.fromRGBO(205, 209, 220, 1),
                  height: 22,
                  width: 22,
                )),
            activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('home.png'),
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  height: 22,
                  width: 22,
                )),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('pray.png'),
                  color: const Color.fromRGBO(205, 209, 220, 1),
                  height: 22,
                  width: 22,
                )),
            activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('pray.png'),
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  height: 22,
                  width: 22,
                )),
            label: 'Pray',
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('book.png'),
                  color: const Color.fromRGBO(205, 209, 220, 1),
                  height: 22,
                  width: 22,
                )),
            activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('book.png'),
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  height: 22,
                  width: 22,
                )),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('events.png'),
                  color: const Color.fromRGBO(205, 209, 220, 1),
                  height: 22,
                  width: 22,
                )),
            activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  assetPath('events.png'),
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  height: 22,
                  width: 22,
                )),
            label: 'Events',
          ),
        ],
        currentIndex: _getIndex(context),
        unselectedItemColor: const Color.fromRGBO(205, 209, 220, 1),
        selectedItemColor: const Color.fromRGBO(4, 26, 82, 1),
        selectedLabelStyle: const TextStyle(
            fontSize: 12, fontFamily: 'FiraSans', fontWeight: FontWeight.w500),
        showUnselectedLabels: true,
        onTap: (index) => _onItemTapped(index, context),
      );

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 1:
        model!.selectMenuItem!(
          context: context,
          route: '/_/pray',
        );
        break;
      case 2:
        model!.selectMenuItem!(
          context: context,
          route: '/_/info',
        );
        break;
      case 3:
        model!.selectMenuItem!(
          context: context,
          route: '/_/events',
        );
        break;
      default:
        model!.selectMenuItem!(
          context: context,
          route: '/_/welcome',
        );
    }
  }

  int _getIndex(BuildContext context) {
    var route = App.getRouteName(context);
    switch (route) {
      case '/_/pray':
      case '/_/mass_readings':
      case '/_/scripture':
        return 1;
      case '/_/info':
      case '/_/schedules':
      case '/_/church_info':
      case '/_/priest_info':
      case '/_/offertory':
        return 2;
      case '/_/events':
        return 3;
      default:
        return 0;
    }
  }
}
