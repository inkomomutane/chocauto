import 'package:flutter/material.dart';

class CardUI extends StatelessWidget {
  const CardUI(
      {Key? key,
      required this.logo,
      required this.content,
      this.subtitle,
      required this.symbol})
      : super(key: key);
  final IconData logo;
  final String content;
  final String symbol;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
      child: Container(
        padding: EdgeInsets.all(4),
        child: ListTile(
          leading: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              child: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(logo),
                ),
              )),
          title: Text(
            content,
            style: TextStyle(
                fontFamily: "Segoe",
                color: Color(0xFF4d4d50),
                fontSize: 14,
                shadows: [Shadow(color: Colors.blue.shade100)],
                letterSpacing: 1,
                fontWeight: FontWeight.w600),
          ),
          trailing: Text(symbol,
              style: TextStyle(
                  color: Color(0xFF4d4d50),
                  shadows: [Shadow(color: Colors.blue.shade100)],
                  letterSpacing: 2,
                  fontSize: 15,
                  fontWeight: FontWeight.w800)),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2))),
      ),
    );
  }
}
