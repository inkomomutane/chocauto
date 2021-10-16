import 'package:chocauto/Components/LabelComponent.dart';
import 'package:flutter/material.dart';

class ChocadeiraEstatistica extends StatefulWidget {
  const ChocadeiraEstatistica({Key? key}) : super(key: key);

  @override
  _ChocadeiraEstatisticaState createState() => _ChocadeiraEstatisticaState();
}

class _ChocadeiraEstatisticaState extends State<ChocadeiraEstatistica> {
  @override
  bool up = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chocadeira"),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          LabelComponent(labelText: "Temperatura e Humidade actual"),
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
                              '27.0 ',
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
                              '58.6',
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
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                up = !up;
              });
            },
            child: Icon(
              up
                  ? Icons.arrow_circle_up_rounded
                  : Icons.arrow_circle_down_rounded,
              color: Colors.amber.shade700,
              size: MediaQuery.of(context).size.width * 0.7,
            ),
          )),
        ],
      ),
    );
  }
}
