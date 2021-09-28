import 'package:chocauto/CardUI.dart';
import 'package:flutter/material.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({Key? key}) : super(key: key);

  @override
  _HomeSceenState createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber.shade100,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('splash/logo.png'))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardUI(
              icon: Icons.wb_cloudy,
              content: "25.5",
              symbol: "h",
            )
          ],
        ),
      ),
    );
  }
}
