import 'package:chocauto/login/Register/FormComponents.dart';
import 'package:flutter/material.dart';

import 'FormComponents.dart';

class MobileMode extends StatefulWidget {
  const MobileMode({Key? key}) : super(key: key);

  @override
  _MobileModeState createState() => _MobileModeState();
}

class _MobileModeState extends State<MobileMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
          color: Colors.amber.shade300,
          child: Center(
              child: Card(
                  elevation: 9,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              child: Container(
                                child: Image(
                                  image: AssetImage("images/logo.png"),
                                ),
                              ),
                              padding: EdgeInsets.all(8),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: Container(child: FormComponents()),
                            )),
                      ],
                    ),
                  ))),
        ));
  }
}
