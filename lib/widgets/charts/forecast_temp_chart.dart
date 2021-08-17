import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:weather_app/logic/forecast_temp_series.dart';

class ForecastTempChart extends StatelessWidget {
  final List<ForecastTempSeries> data;

  ForecastTempChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ForecastTempSeries, DateTime>> series = [
      charts.Series(
          id: "Rain",
          data: data,
          domainFn: (ForecastTempSeries series, _) => series.time,
          measureFn: (ForecastTempSeries series, _) => series.temperature,
          labelAccessorFn: (ForecastTempSeries series, _) =>
              '${series.temperature.toString()} °C')
    ];

    return Container(
      height: 400,
      width: 400,
      padding: EdgeInsets.all(20),
      child: Card(
          child: Column(
        children: [
          Text("Температура на 5 дней", textScaleFactor: 1.2,),
          Expanded(
            child: charts.TimeSeriesChart(
              series,
              animate: true,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
          ))
        ],
      )),
    );
  }
}
