import 'dart:math';
import 'dart:ui';
import 'package:chocauto/ChocadeiraEstatistica.dart';
import 'package:chocauto/ChocadeiraEstatisticaGeral.dart';
import 'package:chocauto/ChocadeiraUI.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Controllers/AppController.dart';
import 'Models/Chocadeira.dart';

class EstatisticaScreen extends StatefulWidget {
  const EstatisticaScreen({Key? key}) : super(key: key);

  @override
  _EstatisticaScreenState createState() => _EstatisticaScreenState();
}

class _EstatisticaScreenState extends State<EstatisticaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.thermostat),
                        ),
                        subtitle: Text(""),
                        title: Text("Cocadeiras "),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Expanded(
            flex: MediaQuery.of(context).size.height > 450
                ? 4
                : MediaQuery.of(context).size.height > 350
                    ? 2
                    : 1,
            child: ValueListenableBuilder<Box<Chocadeira>>(
                valueListenable: AppController.getChocadeiras().listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) => chocadeiras(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ChocadeiraEstatisticaGeral(),
                                fullscreenDialog: true,
                              )),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/logo.png'),
                          ),
                          title: capitalize(box.getAt(index)!.nome),
                          subtitle: " ${box.getAt(index)!.bluetoothDevice}",
                          active: false));
                }),
          )
        ],
      ),
    );
  }

  Widget chocadeiras(
      {required Widget leading,
      bool active = false,
      required String title,
      required String subtitle,
      required void Function() onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Container(
            child: ListTile(
              leading: leading,
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(subtitle),
              trailing: Icon(
                Icons.bluetooth_connected,
                color: active ? Colors.green : Colors.grey,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
          ),
        ));
  }

  capitalize(String title) {
    return title.substring(0, 1).toUpperCase() + title.substring(1);
  }
}
