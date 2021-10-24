import 'dart:ui';

import 'package:chocauto/EstatisticaScreen.dart';
import 'package:chocauto/HomePageScreen.dart';
import 'package:chocauto/TestUi.dart';
import 'package:flutter/material.dart';

import 'Components/NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      //   backgroundColor: Colors.white,

      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[TestUI(),TestUI()],
        ),
      ),
      bottomNavigationBar: NavyBar(
        backgroundColor: Color(0xFFefefef),
        showElevation: false,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text(
                'Home',
                style: TextStyle(color: Colors.grey.shade800),
              ),
              icon: Icon(
                Icons.apps,
                color: Colors.grey.shade800,
              ),
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: Text(
                'Estatísticas',
                style: TextStyle(color: Colors.grey.shade800),
              ),
              icon: Icon(
                Icons.add_chart_outlined,
                color: Colors.grey.shade800,
              ),
              activeColor: Colors.white.withOpacity(1)),
        ],
      ),
    );
  }
}
