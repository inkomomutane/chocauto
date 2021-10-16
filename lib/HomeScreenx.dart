import 'dart:convert';
import 'dart:typed_data';

import 'package:chocauto/CardUI.dart';
import 'package:chocauto/Components/LabelComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({Key? key, required this.server}) : super(key: key);
  final BluetoothDevice server;

  @override
  _HomeSceenState createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  static final clientID = 0;
  BluetoothConnection? connection;

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  bool angle = false;
  String temperatuere = "0";
  String humidity = "0";
  String chocadeira = "";
  @override
  void initState() {
    angle = !angle;
    temperatuere = "0";
    humidity = "0";
    chocadeira = "Matacuane";
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  void _onDataReceived(Uint8List data) {
    String datax = utf8.decode(data);
    List<String> datas = datax.split("%");
    setState(() {
      this.temperatuere = datas[0];
      this.humidity = datas[1];
    });
  }

  void _sendData(int text) async {
    if (text > 0) {
      try {
        connection!.output.add(Uint8List.fromList([text]));
        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
          elevation: 0,
          title: (isConnecting
              ? Text('Connecting chat to ' + serverName + '...')
              : isConnected
                  ? Text('Live chat with ' + serverName)
                  : Text('Chat log with ' + serverName))),
      body: Container(
        //color: Colors.grey.shade100,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFFf1eefe),
                Color(0xFFf1eefe),
                Color(0xFFfbf3ce),
                Color(0xFFfbf3ce),
                Color(0xFFfbf3ce),
                Color(0xFFfbf3ce),
              ]),
        ),

        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(0))),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelComponent(
                      labelText: chocadeira,
                    ),
                    CardUI(
                        logo: Icons.thermostat,
                        content: 'Temperatura',
                        symbol: '$temperatuere ⁰c'),
                    CardUI(
                        logo: Icons.thermostat_auto,
                        content: 'Humidade',
                        symbol: '$humidity %'),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            angle = !angle;
                            _sendData((angle ? 90 : 2));
                          });
                        },
                        child: CardUI(
                            logo: angle
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            content: 'Angulo',
                            symbol: angle ? '90⁰' : '0⁰'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
