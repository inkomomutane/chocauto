import 'package:flutter/material.dart';

class CardUI extends StatelessWidget {
  const CardUI(
      {Key? key,
      required this.icon,
      required this.content,
      required this.symbol})
      : super(key: key);
  final IconData? icon;
  final String content;
  final String symbol;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Card(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Padding(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
              child: Icon(
                icon,
                size: 50,
                color: Colors.amber.shade900,
              ),
            )),
            Container(
                child: Padding(
                    padding: EdgeInsets.only(right: 45, top: 8, bottom: 8),
                    child: Text(
                      '$content $symbol',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.amber.shade900,
                        fontSize: 40,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
