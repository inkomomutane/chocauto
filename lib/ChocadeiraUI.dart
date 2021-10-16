import 'dart:async';
import 'package:chocauto/Arduino.dart';
import 'package:chocauto/Components/LabelComponent.dart';
import 'package:chocauto/Components/SelectComponent.dart';
import 'package:chocauto/Components/TextComponent.dart';
import 'package:chocauto/Controllers/AppController.dart';
import 'package:chocauto/Models/Chocadeira.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'Models/Auth.dart';

class ChocadeiraUI extends StatefulWidget {
  const ChocadeiraUI({Key? key}) : super(key: key);

  get checkAvailability => false;

  @override
  _ChocadeiraUIState createState() => _ChocadeiraUIState();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _ChocadeiraUIState extends State<ChocadeiraUI> {
  List<_DeviceWithAvailability> devices =
      List<_DeviceWithAvailability>.empty(growable: true);

  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription?.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Widget cardDevice({required _DeviceWithAvailability device}) {
    return ListTile(
      title: Text(device.device.name ?? ""),
      leading: Icon(
        Icons.bluetooth,
        color: device.availability.index == 3 ? Colors.green : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (devices.isNotEmpty) {
      var list = devices.map((e) => e.device).toList();
      var str = devices.map((e) => e.device.name).toList();
      BluetoothDevice device = list.first;
      String name = "";
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Registar Chocadeira"),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelComponent(labelText: "Nome da chocadeira"),
                  TextComponent(
                    hintText: "Nome da chocadeira",
                    onChanged: (value) => setState(() {
                      name = value;
                    }),
                    onSaved: (value) => setState(() {
                      name = value ?? "";
                    }),
                    validator: (string) {
                      if (string == null || string.length < 1)
                        return "Insira o nome da chocadeira";
                      else
                        return null;
                    },
                  ),
                  LabelComponent(labelText: "Dispositivo de conexão"),
                  SelectComponent(
                    hintText: "Dispositivo de conexão",
                    items: list,
                    itemAsString: (BluetoothDevice e) => e.name ?? "",
                    onChanged: (BluetoothDevice? value) => setState(() {
                      device = value ?? device;
                    }),
                    onSaved: (BluetoothDevice? value) => setState(() {
                      device = value ?? device;
                    }),
                  )
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await AppController.getChocadeiras().add(new Chocadeira(
                  id: 1,
                  nome: name,
                  bluetoothDevice: device.address,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now()));
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Por favor Verifique e preencha os campos corretamente.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Icon(Icons.save_alt),
          backgroundColor: Color(0xFFffecb3),
        ),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Por favor conecte -se a pelo menos 1 bluetooth"),
        ),
      );
  }
}
