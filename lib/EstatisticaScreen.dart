import 'dart:ui';
import 'package:chocauto/ChocadeiraEstatistica.dart';
import 'package:chocauto/ChocadeiraEstatisticaGeral.dart';
import 'package:chocauto/ChocadeiraUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'Controllers/AppController.dart';
import 'Models/Chocadeira.dart';

class EstatisticaScreen extends StatefulWidget {
  const EstatisticaScreen({Key? key}) : super(key: key);

  @override
  _EstatisticaScreenState createState() => _EstatisticaScreenState();
}

class _EstatisticaScreenState extends State<EstatisticaScreen> {
  List<Chocadeira> _chocadeiras = [];
  @override
  void initState() {
    _chocadeiras = AppController.getChocadeiras().values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFefefef),
      body: Stack(fit: StackFit.expand, children: [
        Container(
            margin: EdgeInsets.only(top: 50),
            child: ValueListenableBuilder<Box<Chocadeira>>(
                valueListenable: AppController.getChocadeiras().listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) => chocadeiras(
                          chocadeira: box.values.elementAt(index),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ChocadeiraEstatisticaGeral(
                                  chocadeira: box.values.elementAt(index),
                                ),
                                fullscreenDialog: true,
                              )),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/logo.png'),
                          )));
                })),
        buildFloatingSearchBar(),
      ]),
    );
  }

  Widget chocadeiras(
      {required Widget leading,
      required Chocadeira chocadeira,
      required void Function() onTap}) {
    BluetoothDevice device =
        new BluetoothDevice(address: chocadeira.bluetoothDevice);
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Container(
            child: ListTile(
              leading: leading,
              title: Text(
                chocadeira.nome,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(chocadeira.bluetoothDevice),
              trailing: Icon(
                Icons.bluetooth_connected,
                color: device.bondState.isBonded ? Colors.green : Colors.grey,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Pesquisar chocadeiras...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: MediaQuery.of(context).size.width * 0.95,
      debounceDelay: const Duration(milliseconds: 200),
      onQueryChanged: (query) {
        setState(() {
          _chocadeiras = AppController.getChocadeiras()
              .values
              .where((element) =>
                  element.nome.toLowerCase().contains(query.toLowerCase()))
              .toList();
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _chocadeiras.map((e) {
                return chocadeiras(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ChocadeiraEstatisticaGeral(
                            chocadeira: e,
                          ),
                          fullscreenDialog: true,
                        )),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                    chocadeira: e);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
