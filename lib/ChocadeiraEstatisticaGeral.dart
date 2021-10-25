import 'package:chocauto/Controllers/AppController.dart';
import 'package:chocauto/Models/Chocadeira.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'Models/Dash.dart';

class ChocadeiraEstatisticaGeral extends StatefulWidget {
  const ChocadeiraEstatisticaGeral({Key? key, required this.chocadeira})
      : super(key: key);
  final Chocadeira chocadeira;
  @override
  _ChocadeiraEstatisticaGeralState createState() =>
      _ChocadeiraEstatisticaGeralState(chocadeira: chocadeira);
}

class _ChocadeiraEstatisticaGeralState
    extends State<ChocadeiraEstatisticaGeral> {
  final Chocadeira chocadeira;
  _ChocadeiraEstatisticaGeralState({required this.chocadeira});

  List<Dash> _dashes = [];

  @override
  void initState() {
    _dashes = AppController.getDashs().values.where((element) {
      return element.chocadeiraId
              .toLowerCase()
              .compareTo(chocadeira.id.toLowerCase()) ==
          0;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFefefef),
        appBar: AppBar(
          backgroundColor: Color(0xFFefefef),
          title: Text(chocadeira.nome.substring(0, 1).toUpperCase() +
              chocadeira.nome.substring(1)),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then((value) {
                    setState(() {
                      _dashes =
                          AppController.getDashs().values.where((element) {
                        return element.createdAt.isAfter(
                                value != null ? value.start : DateTime(2000)) &&
                            element.createdAt.isBefore(
                                value != null ? value.end : DateTime.now()) &&
                            element.chocadeiraId.toLowerCase()
                                    .compareTo(chocadeira.id.toLowerCase()) ==
                                0;
                      }).toList();
                    });
                  });
                },
                icon: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.grey.shade500.withOpacity(0.8),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 220,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: SfCartesianChart(
                    title: ChartTitle(
                        text: "Últimos 5 dias - Temperatura (⁰c)",
                        alignment: ChartAlignment.near,
                        borderWidth: 8,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade800)),
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),

                    // adding multiple axis
                    series: <ChartSeries>[
                      LineSeries<SalesData, String>(
                        dataSource: (_dashes.length >= 5
                            ? List.generate(5, (index) {
                                return SalesData(
                                    "$index. (${_dashes.elementAt(index).createdAt.day})",
                                    _dashes.elementAt(index).temperetura,
                                    0);
                              })
                            : List.generate(_dashes.length, (index) {
                                return SalesData("$index",
                                    _dashes.elementAt(index).temperetura, 0);
                              })),
                        xValueMapper: (SalesData sales, _) => sales.index,
                        yValueMapper: (SalesData sales, _) => sales.value,
                        color: Colors.amber,
                        enableTooltip: true,
                      ),
                    ]),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      child: SfRadialGauge(
                        title: GaugeTitle(
                            text: "Temperatura",
                            alignment: GaugeAlignment.near,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.grey.shade800)),
                        axes: [
                          RadialAxis(
                              minimum: 0,
                              maximum: 150,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 150,
                                    color: Colors.green),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  needleEndWidth: 4,
                                  value: mediaDashs(_dashes)[0].toDouble(),
                                  needleLength: 0.8,
                                  enableAnimation: true,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text(
                                            '${mediaDashs(_dashes)[0]}⁰c',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ],
                      ),
                      height: MediaQuery.of(context).size.width * 0.42,
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      child: SfRadialGauge(
                        title: GaugeTitle(
                            alignment: GaugeAlignment.near,
                            text: "Humidade",
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.grey.shade800)),
                        axes: [
                          RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 35,
                                    color: Colors.yellow),
                                GaugeRange(
                                    startValue: 35,
                                    endValue: 40,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 40,
                                    endValue: 100,
                                    color: Colors.red),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  needleEndWidth: 4,
                                  value: mediaDashs(_dashes)[1].toDouble(),
                                  needleLength: 0.8,
                                  enableAnimation: true,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text(
                                            '${mediaDashs(_dashes)[1]} %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ],
                      ),
                      height: MediaQuery.of(context).size.width * 0.42,
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  ],
                ),
              ),
              Container(
                child: SfDataGrid(
                  rowsPerPage: 2,
                  columnWidthMode: ColumnWidthMode.fill,
                  columnResizeMode: ColumnResizeMode.onResize,
                  allowSorting: true,
                  source: new DashRows(_dashes),
                  columns: [
                    GridColumn(
                        columnName: 'Data',
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Data',
                            ))),
                    GridColumn(
                        columnName: 'Temperatura',
                        allowEditing: true,
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Temperatura',
                            ))),
                    GridColumn(
                        columnName: 'Humidade',
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Humidade',
                            ))),
                    GridColumn(
                      columnName: 'Ângulo',
                      label: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Ângulo',
                        ),
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                width: MediaQuery.of(context).size.width * 0.85,
              )
            ],
          ),
        ));
  }

  List<int> mediaDashs(List<Dash> dashs) {
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

class SalesData {
  SalesData(this.index, this.value, [this.numeric]);
  final String index;
  final dynamic value;
  final int? numeric;
}

class DashRows extends DataGridSource {
  List<DataGridRow> _dashs = [];
  DashRows(List<Dash> dashs) {
    _dashs = dashs.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: "Data",
            value: '${DateFormat("dd-M-yyyy").format(e.createdAt)}'),
        DataGridCell<String>(
            columnName: "Temperatura", value: "${e.temperetura}⁰c"),
        DataGridCell<String>(columnName: "Humidade", value: "${e.humidade}%"),
        DataGridCell<String>(columnName: "Ângulo", value: "${e.angulo}⁰"),
      ]);
    }).toList();
  }
  @override
  List<DataGridRow> get rows => _dashs;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
