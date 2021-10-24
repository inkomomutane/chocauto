import 'dart:math';
import 'dart:ui';
import 'package:chocauto/ChocadeiraEstatistica.dart';
import 'package:chocauto/ChocadeiraUI.dart';
import 'package:chocauto/Components/LabelComponent.dart';
import 'package:chocauto/Controllers/AppController.dart';
import 'package:chocauto/Models/Chocadeira.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFefefef),
      body:
     Stack(
      fit: StackFit.expand,
      children: [
       Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: LabelComponent(
                  labelText: "Dashboard",
                )),
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
                            chocadeira: box.values.elementAt(index),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ChocadeiraEstatistica(
                                    chocadeira: box.values.elementAt(index),
                                    title: box.values.elementAt(index).nome,
                                    device: new BluetoothDevice(
                                        address: box.values
                                            .elementAt(index)
                                            .bluetoothDevice),
                                  ),
                                  fullscreenDialog: true,
                                )),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('images/logo.png'),
                            )));
                  })),
                 
        ],
      ),buildFloatingSearchBar(),]),
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
                borderRadius: BorderRadius.all(Radius.circular(25))),
          ),
        ));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
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
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
