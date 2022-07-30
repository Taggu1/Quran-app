import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/core/constants/ints.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/pages/main_page.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var barIndex = bottomNavBarInitialIndex;
  final pages = [
    const MainPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: pages[barIndex],
        bottomNavigationBar: _buildButtonNavBarConvex());
  }

  ConvexAppBar _buildButtonNavBarConvex() {
    return ConvexAppBar(
      style: TabStyle.react,
      backgroundColor: Colors.teal,
      height: 52,
      items: _navBarItemsListConvex(context),
      initialActiveIndex: 0, //optional, default as 0
      onTap: (int currenIndex) => setState(() {
        barIndex = currenIndex;
      }),
    );
  }

  List<TabItem> _navBarItemsListConvex(BuildContext context) {
    return [
      TabItem(
          icon: const Icon(Icons.apps),
          title: AppLocalizations.of(context)!.homePage),
      TabItem(
          icon: const Icon(Icons.settings),
          title: AppLocalizations.of(context)!.settings),
    ];
  }
}



  // BottomNavyBar _buildButtonNavBar() {
  //   return BottomNavyBar(
  //     backgroundColor: Theme.of(context).backgroundColor,

  //     selectedIndex: barIndex,
  //     showElevation: true, // use this to remove appBar's elevation
  //     onItemSelected: (currenIndex) => setState(() {
  //       barIndex = currenIndex;
  //     }),
  //     items: _navBarItemsList(context),
  //   );
  // }

  // List<BottomNavyBarItem> _navBarItemsList(BuildContext context) {
  //   return [
  //     BottomNavyBarItem(
  //       icon: const Icon(Icons.apps),
  //       title: Text(AppLocalizations.of(context)!.homePage),
  //       activeColor: Colors.amber,
  //     ),
  //     BottomNavyBarItem(
  //         icon: const Icon(Icons.settings),
  //         title: Text(AppLocalizations.of(context)!.settings),
  //         activeColor: Colors.purpleAccent),
  //   ];
  // }