import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_app/pages/home.dart';
import 'package:flutter_money_app/pages/profile.dart';
import 'package:flutter_money_app/pages/stats.dart';
import 'package:flutter_money_app/utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentPageIndex = 0;
  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Stats();
      case 2:
        return Container();
      case 3:
        return const Profile();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildTabContent(_currentPageIndex),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  stops: [
                    0.1,
                    0.15,
                    0.4,
                    0.8,
                  ],
                  colors: [
                    Color(0xFF35a6e5),
                    Color(0xFF42a0e8),
                    Color(0xFFd676db),
                    Color(0xFFf88568)
                  ])),
          child: const Icon(Icons.add),
        ),
        //backgroundColor: LinearGradient(colors: [Color(0xFFce68f8),Color(0xFF8086f2),Color(0xFFf18991),Color(0xFFf48d87)),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.home,
      Icons.insert_chart_sharp,
      Icons.wallet,
      Icons.person,
    ];
    return AnimatedBottomNavigationBar(
        icons: iconItems,
        activeColor: selectedColor,
        splashColor: Secondary,
        inactiveColor: fontLight.withOpacity(0.5),
        activeIndex: _currentPageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        onTap: (index) =>
          setState(() =>
            _currentPageIndex = index
          ),
        );
  }
}
