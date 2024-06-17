import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../widgets/app_gradient_container.dart';
import 'analytic.dart';
import '../../../Explore/calendar.dart';

import 'info.dart';


class MainScreen extends StatefulWidget {
  // final int screen;
  const MainScreen({
    super.key,
    // this.screen = 0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class Screen {
  final String title;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  const Screen(this.title, this.label, this.icon, this.selectedIcon, this.page);
}

class _MainScreenState extends State<MainScreen> {

  int selectedScreen = 0;

  static const List<Screen> screens = [
    Screen(
      'Mood Calendar',
      'Calendar',
      Icons.calendar_month_outlined,
      Icons.calendar_month,
      CalendarScreen(),
    ),
    Screen(
      'Mood Analytics',
      'Analytics',
      Icons.insights_outlined,
      Icons.insights,
      AnalyticScreen(),
    ),
    Screen(
      'Why Track Your Daily Mood?',
      'Guide',
      Icons.self_improvement_outlined,
      Icons.self_improvement,
      InfoScreen(),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(screens[ selectedScreen ].title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: AppGradientContainer(child: screens[ selectedScreen ].page),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(

      ),
      child: NavigationBar(
        indicatorColor: AppColors.indigo100,
        surfaceTintColor: Colors.transparent,
        selectedIndex: selectedScreen,
        onDestinationSelected: (int index) {
          setState(() {
            selectedScreen = index;
          });
        },
        destinations: screens.map((Screen item) {
          return NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: item.label
          );
        }).toList(),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';
import '../widgets/app_gradient_container.dart';
import 'analytic.dart';
import '../../../Explore/calendar.dart';
import 'info.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class Screen {
  final String title;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  const Screen(this.title, this.label, this.icon, this.selectedIcon, this.page);
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Screen> screens = [
    Screen(
      'Mood Calendar',
      'Calendar',
      Icons.calendar_month_outlined,
      Icons.calendar_month,
      CalendarScreen(),
    ),
    Screen(
      'Mood Analytics',
      'Analytics',
      Icons.insights_outlined,
      Icons.insights,
      AnalyticScreen(),
    ),
    Screen(
      'Why Track Your Daily Mood?',
      'Guide',
      Icons.self_improvement_outlined,
      Icons.self_improvement,
      InfoScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: screens.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});  // Update the title on tab change
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(screens[_tabController.index].title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.indigo100,
          tabs: screens.map((Screen item) {
            return Tab(
              icon: Icon(item.icon),
              text: item.label,
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: screens.map((Screen item) {
          return AppGradientContainer(child: item.page);
        }).toList(),
      ),
    );
  }
}
*/
