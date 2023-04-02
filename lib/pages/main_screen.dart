import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_app/data/data_state_notifier.dart';
import 'package:flutter_money_app/pages/EditWidget.dart';
import 'package:flutter_money_app/pages/add.dart';
import 'package:flutter_money_app/pages/home.dart';
import 'package:flutter_money_app/pages/profile.dart';
import 'package:flutter_money_app/pages/stats.dart';
import 'package:flutter_money_app/pages/wallet.dart';
import 'package:flutter_money_app/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(
    const ProviderScope(
    child:MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
var visible = false;
  @override
  Widget build(BuildContext context) {
    
      return Consumer(
       builder: (context, ref, child) {
        
        return Scaffold(
          body: getBody(ref),
          floatingActionButton:Consumer(
            builder: (context, ref, child) {
              final ButtonProvider = ref.watch(visibleButtonProvider);
              return Visibility(
            visible: ButtonProvider,
            child: FloatingActionButton(
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
              onPressed: () {
                setTabs(4,ref);
                ref.read(visibleButtonProvider.notifier).state=false;
              },
            ),
          );}),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar:Consumer(
            builder: (context, ref, child) {
              final ButtonProvider = ref.watch(visibleButtonProvider); 
          return getFooter(ref);})
        
        
        
        
        
        
        );
  },);
    
  }

  Widget getBody(ref) {
    return IndexedStack(
      index: ref.watch(currentPageIndex),
      children: [
        Home(),
        Stats(),
        Wallet(),
         const Profile(),
         AddWidget(),
         EditWidget(),
      ],
    );
  }

  Widget getFooter(WidgetRef ref) {
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
        activeIndex: ref.watch(currentPageIndex),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        onTap: (index) {
          ref.read(visibleButtonProvider.notifier).state=true;
          setTabs(index,ref);

        });
  }

  setTabs(index,ref) {
    ref.read(currentPageIndex.notifier).state=index;
  }
}
