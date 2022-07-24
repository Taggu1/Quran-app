import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quran_app_clean_architecture/src/core/constants/colors.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/pages/main_page.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/pages/settings_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var index = 0;
  final pages = [
    const MainPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlackColor,
        body: pages[index],
        bottomNavigationBar: _buildButtonNavBar());
  }

  BottomNavyBar _buildButtonNavBar() {
    return BottomNavyBar(
      backgroundColor: kBlackColor,
      selectedIndex: index,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (i) => setState(() {
        index = i;
      }),
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: Colors.red,
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            activeColor: Colors.purpleAccent),
      ],
    );
  }
}
