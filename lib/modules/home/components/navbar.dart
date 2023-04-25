import 'package:flutter/material.dart';

import '../models/home_model.dart';

import '../../../utils/asset_path.dart';

class Navbar extends StatefulWidget {
  final HomeModel? model;

  const Navbar({
    super.key,
    this.model,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
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
        currentIndex: widget.model?.selectedIndex ?? 0,
        unselectedItemColor: const Color.fromRGBO(205, 209, 220, 1),
        selectedItemColor: const Color.fromRGBO(4, 26, 82, 1),
        selectedLabelStyle: const TextStyle(
            fontSize: 12, fontFamily: 'FiraSans', fontWeight: FontWeight.w500),
        showUnselectedLabels: true,
        onTap: (index) => _onItemTapped(index, context),
      );

  void _onItemTapped(int index, BuildContext context) {
    widget.model!.setSelectedIndex!(index: index);
    switch (index) {
      case 1:
        widget.model!.selectMenuItem!(
          context: context,
          route: '/_/pray',
        );
        break;
      case 2:
        widget.model!.selectMenuItem!(
          context: context,
          route: '/_/info',
        );
        break;
      case 3:
        widget.model!.selectMenuItem!(
          context: context,
          route: '/_/events',
        );
        break;
      default:
        widget.model!.selectMenuItem!(
          context: context,
          route: '/_/welcome',
        );
    }
  }
}
