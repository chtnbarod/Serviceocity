import 'package:flutter/material.dart';
import 'package:serviceocity/view/booking/view.dart';
import 'package:serviceocity/view/cart/view.dart';
import 'package:serviceocity/view/home/view.dart';
import 'package:serviceocity/view/profile/view.dart';
import 'package:serviceocity/view/wallet/view.dart';

import '../../theme/app_colors.dart';
import 'coming_soon.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  static const List<Widget> _options = <Widget>[
    HomePage(),
    ComingSoon(title: "Reword"),
    ComingSoon(title: "SC Royal"),
    ComingSoon(title: "Offer"),
  ];

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        backgroundColor: AppColors.whiteColor(),
        selectedItemColor: AppColors.primaryColor(),
        unselectedItemColor: AppColors.blackColor().withOpacity(0.4),
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items:  [
          BottomNavigationBarItem(
              icon: Image.asset("assets/menu/home.png",
                height: 24,
                width: 24,
                color: selectedIndex == 0 ? AppColors.primary : Colors.black54,),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/menu/reward.png",
                height: 24,
                width: 24,
                color: selectedIndex == 1 ? AppColors.primary : Colors.black54,),
              label: "Reword"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/menu/royal.png",
                height: 24,
                width: 24,
                color: selectedIndex == 2 ? AppColors.primary : Colors.black54,),
              label: "SC Royal"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/menu/offer.png",
              height: 24,
              width: 24,
              color: selectedIndex == 3 ? AppColors.primary : Colors.black54,),
              label: "Offer"),
        ],
      ),
      body: _options[selectedIndex] ,
    );
  }
}
