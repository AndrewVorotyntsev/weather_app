import 'package:flutter/material.dart';
import 'package:weather_app/widgets/charts/today_temp_chart.dart';

import 'package:weather_app/model/weather_forecast.dart';

import 'package:weather_app/widgets/charts/forecast_temp_chart.dart';

class WeatherTodayCard extends StatelessWidget {
  final WeatherForecast data;

  WeatherTodayCard({@required this.data});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: 1,
        duration: Duration(milliseconds: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
              width: 360,
              height: 180,
              //padding: EdgeInsets.all(10),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      // Row2
                      child: TodayTempChart(
                          data: data.mySeries,
                        )
                      ))),
          Container(
              width: 360,
              height: 180,
              //padding: EdgeInsets.all(10),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      // Row2
                      child: ForecastTempChart(
                        data: data.tempSeries,
                      )
                  )))
        ]));
  }
}
