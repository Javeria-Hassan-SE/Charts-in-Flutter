
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../model/pollution.dart';
import '../model/sales.dart';
import '../model/task.dart';


class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  late List<charts.Series<Pollution, String>> _seriesData;
  late List<charts.Series<Task, String>> _seriesPieData;
  late List<charts.Series<Sales, int>> _seriesLineData;

   @override
  void initState(){
     super.initState();
     _seriesData = <charts.Series<Pollution, String>>[];
     _seriesPieData = <charts.Series<Task, String>>[];
     _seriesLineData = <charts.Series<Sales, int>>[];
     _generateData();
   }
   _generateData(){
      var pieData = [
        Task("Work", 35.6, Colors.blueAccent),
        Task("Exercise", 35.6, Colors.blueGrey),
        Task("Assignment", 35.6, Colors.blueAccent),
        Task("Work", 35.6, Colors.blueAccent),
        Task("Work", 35.6, Colors.blueAccent)
      ];

      var data1 = [
         Pollution(1980, 'USA', 30),
         Pollution(1980, 'Asia', 40),
         Pollution(1980, 'Europe', 10),
      ];
      var data2 = [
         Pollution(1985, 'USA', 100),
         Pollution(1980, 'Asia', 150),
         Pollution(1985, 'Europe', 80),
      ];
      var data3 = [
         Pollution(1985, 'USA', 200),
         Pollution(1980, 'Asia', 300),
         Pollution(1985, 'Europe', 180),
      ];

      var lineSalesData = [
         Sales(0, 45),
         Sales(1, 56),
         Sales(2, 55),
         Sales(3, 60),
         Sales(4, 61),
         Sales(5, 70),
      ];

      _seriesData.add(
        charts.Series(
          domainFn: (Pollution pollution, _) => pollution.place,
          measureFn: (Pollution pollution, _) => pollution.quantity,
          id: '2017',
          data: data1,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (Pollution pollution, _) =>
              charts.ColorUtil.fromDartColor(const Color(0xff990099)),
        ),
      );

      _seriesData.add(
        charts.Series(
          domainFn: (Pollution pollution, _) => pollution.place,
          measureFn: (Pollution pollution, _) => pollution.quantity,
          id: '2018',
          data: data2,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (Pollution pollution, _) =>
              charts.ColorUtil.fromDartColor(const Color(0xff109618)),
        ),
      );

      _seriesData.add(
        charts.Series(
          domainFn: (Pollution pollution, _) => pollution.place,
          measureFn: (Pollution pollution, _) => pollution.quantity,
          id: '2019',
          data: data3,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (Pollution pollution, _) =>
              charts.ColorUtil.fromDartColor(const Color(0xffff9900)),
        ),
      );

      _seriesPieData.add(
        charts.Series(
          domainFn: (Task task, _) => task.task,
          measureFn: (Task task, _) => task.taskValue,
          colorFn: (Task task, _) =>
              charts.ColorUtil.fromDartColor(task.colorValue),
          id: 'Air Pollution',
          data: pieData,
          labelAccessorFn: (Task row, _) => '${row.taskValue}',
        ),
      );

      _seriesLineData.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(const Color(0xff990099)),
          id: 'Air Pollution',
          data: lineSalesData,
          domainFn: (Sales sales, _) => sales.yearVal,
          measureFn: (Sales sales, _) => sales.salesVal,
        ),
      );
      // _seriesLineData.add(
      //   charts.Series(
      //     colorFn: (__, _) => charts.ColorUtil.fromDartColor(const Color(0xff109618)),
      //     id: 'Air Pollution',
      //     data: lineSalesData1,
      //     domainFn: (Sales sales, _) => sales.yearVal,//y-axis
      //     measureFn: (Sales sales, _) => sales.salesVal,//x-axis
      //   ),
      // );
      // _seriesLineData.add(
      //   charts.Series(
      //     colorFn: (__, _) => charts.ColorUtil.fromDartColor(const Color(0xffff9900)),
      //     id: 'Air Pollution',
      //     data: lineSalesData2,
      //     domainFn: (Sales sales, _) => sales.yearVal,
      //     measureFn: (Sales sales, _) => sales.salesVal,
      //   ),
      // );

   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff1976d2),
            bottom: const TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(Icons.bar_chart),
                ),
                Tab(
                  icon: Icon(Icons.pie_chart),
                ),
                Tab(
                  icon: Icon(Icons.stacked_line_chart),
                )
              ],
            ),
            title: const Text('Flutter Charts'),
          ),
          body:  TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'SO₂ emissions, by world region (in million tonnes)',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                      Expanded(
                        child: charts.BarChart(
                          _seriesData,
                          animate: true,
                          barGroupingType: charts.BarGroupingType.grouped,
                          //behaviors: [new charts.SeriesLegend()],
                          animationDuration: const Duration(seconds: 5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Time spent on daily tasks',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10.0,),
                      Expanded(
                        child: charts.PieChart(
                            _seriesPieData,
                            animate: true,
                            animationDuration: const Duration(seconds: 5),
                            // behaviors: [
                            //   charts.DatumLegend(
                            //     outsideJustification: charts.OutsideJustification.endDrawArea,
                            //     horizontalFirst: false,
                            //     desiredMaxRows: 2,
                            //     cellPadding:  const EdgeInsets.only(right: 4.0, bottom: 4.0),
                            //     entryTextStyle: charts.TextStyleSpec(
                            //         color: charts.MaterialPalette.purple.shadeDefault,
                            //         fontFamily: 'Georgia',
                            //         fontSize: 11),
                            //   )
                            // ],
                            // defaultRenderer:  charts.ArcRendererConfig(
                            //     arcWidth: 100,
                            //     arcRendererDecorators: [
                            //        charts.ArcLabelDecorator(
                            //           labelPosition: charts.ArcLabelPosition.inside)
                            //     ])
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Sales for the first 5 years',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                      Expanded(
                        child: charts.LineChart(
                            _seriesLineData,
                            defaultRenderer:  charts.LineRendererConfig(
                                includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: const Duration(seconds: 5),
                            // behaviors: [
                            //    charts.ChartTitle('Years',
                            //       behaviorPosition: charts.BehaviorPosition.bottom,
                            //       titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                            //    charts.ChartTitle('Sales',
                            //       behaviorPosition: charts.BehaviorPosition.start,
                            //       titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                            //    charts.ChartTitle('Departments',
                            //     behaviorPosition: charts.BehaviorPosition.end,
                            //     titleOutsideJustification:charts.OutsideJustification.middleDrawArea,
                            //   )
                            // ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
