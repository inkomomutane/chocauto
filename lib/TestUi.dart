import 'package:chocauto/Models/Auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

import 'Models/Dash.dart';

class TestUI extends StatefulWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  _TestUIState createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFefefef),
        appBar: AppBar(
          backgroundColor: Color(0xFFefefef),
          title: Text("Tata"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then((value) => print(value));
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
                        text: "Gráfico de temperatura",
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
                        dataSource: [
                          SalesData("1", 23, 45),
                          SalesData("2", 21, 45),
                          SalesData("3", 33, 45),
                          SalesData("4", 33, 45),
                          SalesData("5", 23, 45)
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
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
                                  value: 40,
                                  needleLength: 0.8,
                                  enableAnimation: true,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text('0%',
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
                                  value: 40,
                                  needleLength: 0.8,
                                  enableAnimation: true,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text('0⁰c',
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
                  source: new DashRows(List.generate(
                      45,
                      (index) => new Dash(
                          id: "id",
                          temperetura: 2,
                          humidade: 4,
                          angulo: 4,
                          horario: DateTime.now(),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          auth: new Auth(
                              username: "username", password: "password"),
                          chocadeiraId: "chocadeiraId"))),
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
}

class SalesData {
  SalesData(this.year, this.sales, [this.numeric]);
  final String year;
  final int? sales;
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
  


/**<SalesData, String>(
                      dataSource: [
                        SalesData("1", 23, 45),
                        SalesData("2", 21, 45),
                        SalesData("3", 33, 45),
                        SalesData("4", 33, 45),
                        SalesData("5", 23, 45)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales) */