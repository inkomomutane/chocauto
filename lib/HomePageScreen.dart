import 'dart:math';
import 'dart:ui';
import 'package:chocauto/ChocadeiraEstatistica.dart';
import 'package:chocauto/ChocadeiraUI.dart';
import 'package:chocauto/Controllers/AppController.dart';
import 'package:chocauto/Models/Chocadeira.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

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
                        subtitle: Text("xdddddddddddddddddd"),
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
              child: ListView.builder(
                  itemCount: AppController.getChocadeiras().length,
                  itemBuilder: (context, index) => chocadeiras(
                      chocadeira: AppController.getChocadeiras()
                          .values
                          .elementAt(index),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                ChocadeiraEstatistica(),
                            fullscreenDialog: true,
                          )),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('images/logo.png'),
                      ),
                      title: "Chocadeira",
                      subtitle: "Tempretura ",
                      active: Random().nextBool()))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFffecb3),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ChocadeiraUI(),
            fullscreenDialog: true,
          ),
        ),
      ),
    );
  }

  Widget chocadeiras(
      {required Widget leading,
      required Chocadeira chocadeira,
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
                chocadeira.nome
                ,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(chocadeira.bluetoothDevice),
              trailing: Icon(
                Icons.bluetooth_connected,
                   color: Colors.grey,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
          ),
        ));
  }
}
