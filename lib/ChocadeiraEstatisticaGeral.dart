import 'package:chocauto/Components/LabelComponent.dart';
import 'package:chocauto/Controllers/AppController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Models/Dash.dart';

class ChocadeiraEstatisticaGeral extends StatefulWidget {
  const ChocadeiraEstatisticaGeral({Key? key}) : super(key: key);

  @override
  _ChocadeiraEstatisticaGeralState createState() =>
      _ChocadeiraEstatisticaGeralState();
}

class _ChocadeiraEstatisticaGeralState
    extends State<ChocadeiraEstatisticaGeral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chocadeira"),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelComponent(labelText: "Temperatura e Humidade Média"),
          Expanded(
            child: Padding(
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 25),
                          child: Row(
                            children: [
                              Text(
                                '${mediaDashs()[0]}',
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 25),
                          child: Row(
                            children: [
                              Text(
                                '${mediaDashs()[1]}',
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
          ),
          Expanded(
              flex: MediaQuery.of(context).size.height > 450
                  ? 4
                  : MediaQuery.of(context).size.height > 350
                      ? 2
                      : 1,
              child: ListView.builder(
                  itemCount: AppController.getDashs().length,
                  itemBuilder: (context, index) => card(
                      dash: AppController.getDashs().values.elementAt(index)))),
        ],
      ),
    );
  }

  Widget card({required Dash dash}) {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 25, right: 25),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${DateFormat("dd-M-yyyy").format(dash.createdAt)}"),
              Text('T: ${dash.temperetura}⁰c'),
              Text('H: ${dash.humidade}%')
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }

  List<int> mediaDashs() {
    var dashs = AppController.getDashs().values.toList();
    var hm = 0.0;
    var tmp = 0.0;

    if (dashs.isNotEmpty) {
      dashs.forEach((element) {
        hm += element.humidade;
        tmp += element.temperetura;
      });
      return [(tmp ~/ dashs.length).toInt(), (hm ~/ dashs.length).toInt()];
    } else
      return [0, 0];
  }
}
