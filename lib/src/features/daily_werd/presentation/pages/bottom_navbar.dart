import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:translucent_navigation_bar/translucent_navigation_bar.dart';

import '../../../../core/constants/ints.dart';
import '../../../progress/presentation/pages/insights_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../bloc/werd/werd_bloc.dart';
import 'main_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  int maxCount = 2;
  int selectedIndex = 1;

  var barIndex = bottomNavBarInitialIndex;
  final pages = [
    const MainPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(pages.length, (index) => pages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: BottomNavBarWidget(
          pageController: _pageController,
        ));
  }

  ConvexAppBar _buildButtonNavBarConvex() {
    return ConvexAppBar(
      style: TabStyle.react,
      backgroundColor: Colors.teal,
      height: 52,
      items: _navBarItemsListConvex(context),
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
        icon: const Icon(Icons.insights),
        title: AppLocalizations.of(context)!.progress,
      ),
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

class BottomNavBarWidget extends StatefulWidget {
  final PageController pageController;
  const BottomNavBarWidget({super.key, required this.pageController});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WerdBloc, WerdState>(
      builder: (context, state) {
        final werd = state.werd;
        bool isPlaying = false;

        if (werd.audio != null) {
          isPlaying = werd.isAudioPlaying;
        }

        return TranslucentNavigationBar(
          borderRadius: 12,
          verticalPadding: 25,
          horizontalPadding: 50,
          height: 70,
          mainTranslucentNavigationBarItem: TranslucentNavigationBarItem(
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
            widget.pageController.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
          onMainIconTap: () {
            final werdState = context.read<WerdBloc>().state;
            if (werdState is LoadedWerdState) {
              final werd = werdState.werd;
              context.read<WerdBloc>().add(
                    TogglePlayerPlayingStateEvent(play: !isPlaying),
                  );
            }
          },
          selectedIndex: selectedIndex,
          mainIconBackgroundColor: Colors.teal,
          mainIconColor: Colors.white,
          items: [
            TranslucentNavigationBarItem(
              iconData: Icons.home,
            ),
            TranslucentNavigationBarItem(
              iconData: Icons.person,
            ),
          ],
        );
      },
    );
  }
}
