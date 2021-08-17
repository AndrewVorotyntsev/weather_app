import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/logic/today_temp_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TodayTempChart extends StatelessWidget{

  final List<TodayTempSeries> data;

  TodayTempChart({@required this.data});

  @override
  Widget build(BuildContext context) {

    List<charts.Series<TodayTempSeries, String>> series = [
      charts.Series(
          id: "Rain",
          data: data,
          domainFn: (TodayTempSeries series, _) => series.time,
          measureFn: (TodayTempSeries series, _) => series.temperature,
          colorFn: (TodayTempSeries series, _) => charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (TodayTempSeries series, _) => '${series.temperature.toString()}'
      )

    ];

    return Container(
      height: 400,
      width: 400,
      padding: EdgeInsets.all(20),
      child: Card(
          child: Column(
            children: [
              Text("Температура в течение дня", textScaleFactor: 1.2,),
              Expanded(child:
              charts.BarChart(
                series,
                animate: true,
                barRendererDecorator: new charts.BarLabelDecorator<String>(),
              )
              )
            ],
          )
      ),
    );
  }

}
