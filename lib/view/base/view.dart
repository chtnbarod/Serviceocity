import 'package:flutter/material.dart';
import 'package:serviceocity/view/home/view.dart';

import '../../theme/app_colors.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  static const List<Widget> _options = <Widget>[
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
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
        items:  const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.campaign),
              label: "Rewards"),
          BottomNavigationBarItem(
              icon: Icon(Icons.crop),
              label: "SC Royal"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: "Offer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Booking"),
        ],
      ),
      body: _options[selectedIndex] ,
    );
  }
}
