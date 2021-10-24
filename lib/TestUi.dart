import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
      body: ListView(
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
                    text: "Graph",
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
                      RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 25, color: Colors.blue),
                        GaugeRange(
                            startValue: 26,
                            endValue: 40,
                            color: Colors.green.shade400),
                        GaugeRange(
                            startValue: 40,
                            endValue: 100,
                            color: Colors.red.shade500)
                      ], pointers: <GaugePointer>[
                        NeedlePointer(
                          value: 40,
                          enableAnimation: true,
                        )
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('0 ⁰C',
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
                      RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 150, color: Colors.white),
                      ], pointers: <GaugePointer>[
                        NeedlePointer(
                          value: 40,
                          enableAnimation: true,
                        )
                      ], annotations: <GaugeAnnotation>[
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
                      color: Colors.blue.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales, [this.numeric]);
  final String year;
  final int? sales;
  final int? numeric;
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