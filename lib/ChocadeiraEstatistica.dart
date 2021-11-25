import 'dart:convert';
import 'dart:typed_data';

import 'package:chocauto/Components/LabelComponent.dart';
import 'package:chocauto/Controllers/AppController.dart';
import 'package:chocauto/Models/Chocadeira.dart';
import 'package:chocauto/Models/Dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:uuid/uuid.dart';

class ChocadeiraEstatistica extends StatefulWidget {
  const ChocadeiraEstatistica(
      {Key? key,
      required this.title,
      required this.device,
      required this.chocadeira})
      : super(key: key);
  final String title;
  final BluetoothDevice device;
  final Chocadeira chocadeira;
  @override
  _ChocadeiraEstatisticaState createState() => _ChocadeiraEstatisticaState(
      title: title, device: device, chocadeira: chocadeira);
}

class _ChocadeiraEstatisticaState extends State<ChocadeiraEstatistica> {
  _ChocadeiraEstatisticaState(
      {required this.title, required this.device, required this.chocadeira});
  final String title;
  final BluetoothDevice device;
  BluetoothConnection? connection;
  final Chocadeira chocadeira;
  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  bool angle = false;
  String temperature = "0";
  String humidity = "0";
  String terminal = "5";

  @override
  void initState() {
    angle = false;
    temperature = "0";
    humidity = "0";
    terminal = "5";
    super.initState();

    BluetoothConnection.toAddress(device.address).then((_connection) {
      print('Connectado');
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
          print('Disconectando localmente!');
          terminal = 'Disconectando localmente!';
        } else {
          print('Disconectando remotamente!');
          terminal = 'isconectando remotamente!';
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
    String datax = utf8.decode(data, allowMalformed: true);

    List<String> datas = datax.split("%");
    print(datas);

    setState(() {
      terminal = datax;
      debugPrint(terminal);
      if (datas.length > 1) {
        if (datas[0].isNotEmpty && datas[1].isNotEmpty) {
          this.temperature = datas[0];
          this.humidity = datas[1];

          if (AppController.getDashs().values.isNotEmpty) {
            if (AppController.getDashs()
                        .values
                        .first
                        .humidade
                        .compareTo(double.parse(this.humidity)) !=
                    0 &&
                AppController.getDashs()
                        .values
                        .first
                        .temperetura
                        .compareTo(double.parse(this.temperature)) !=
                    0)
              AppController.getDashs()
                  .add(new Dash(
                      id: Uuid().v4(),
                      temperetura: double.parse(this.temperature),
                      humidade: double.parse(this.humidity),
                      angulo: up ? 90 : 0,
                      horario: DateTime.now(),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      auth: AppController.getAuths().values.first,
                      chocadeiraId: chocadeira.id))
                  .then((value) => print(value));
          } else
            AppController.getDashs()
                .add(new Dash(
                    id: Uuid().v4(),
                    temperetura: double.parse(this.temperature),
                    humidade: double.parse(this.humidity),
                    angulo: up ? 90 : 0,
                    horario: DateTime.now(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    auth: AppController.getAuths().values.first,
                    chocadeiraId: chocadeira.id))
                .then((value) => print(value));
        }
      }
    });
  }

  void _sendData(int text) async {
   // print(text);
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
  bool up = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isConnecting ? "Conectando ... " : capitalize(title)),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          LabelComponent(labelText: "Temperatura e humidade actual"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 25),
                        child: Text(
                          'Temperatura',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 25, bottom: 25),
                        child: Row(
                          children: [
                            Text(
                              '$temperature',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '⁰c',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 25),
                        child: Text(
                          'Humidade',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10, right: 25, bottom: 25),
                        child: Row(
                          children: [
                            Text(
                              '$humidity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                up = !up;
                _sendData(up ? 45 : 2);
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
              child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  backgroundColor: Colors.white,
                  title: GaugeTitle(
                      text: "Ângulo",
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade800,
                          fontSize: 24)),
                  axes: <RadialAxis>[
                    RadialAxis(
                        isInversed: true,
                        endAngle: 360,
                        startAngle: 0,
                        minimum: 0,
                        maximum: 360,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 360,
                              color: Colors.green),
                          GaugeRange(
                              startValue: 0,
                              endValue: 90,
                              color: Colors.blue.shade300)
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: up ? 45 : 0,
                            enableAnimation: true,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text('${up ? 45 : 0}⁰',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                              angle: 90,
                              positionFactor: 0.5)
                        ])
                  ]),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.9,
                    offset: Offset.fromDirection(2))
              ]),
            ),
          ),
        ],
      ),
    );
  }

  capitalize(String title) {
    return title.substring(0, 1).toUpperCase() + title.substring(1);
  }
}
