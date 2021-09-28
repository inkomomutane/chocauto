import 'package:chocauto/CardUI.dart';
import 'package:flutter/material.dart';

class EstatisticaScreen extends StatefulWidget {
  const EstatisticaScreen({Key? key}) : super(key: key);

  @override
  _EstatisticaScreenState createState() => _EstatisticaScreenState();
}

class _EstatisticaScreenState extends State<EstatisticaScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('splash/logo.png'))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardUI(
              icon: Icons.wb_sunny_outlined,
              content: "45",
              symbol: "⁰C",
            ),
            CardUI(
              icon: Icons.wb_sunny_outlined,
              content: "45",
              symbol: "⁰C",
            ),
            CardUI(
              icon: Icons.wb_sunny_outlined,
              content: "45",
              symbol: "⁰C",
            )
          ],
        ),
      ),
    );
  }
}
