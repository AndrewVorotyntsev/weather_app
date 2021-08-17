import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather.dart';

class WeatherNowCard extends StatelessWidget {
  final CurrentWeather data;

  WeatherNowCard({@required this.data});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: 1,
        duration: Duration(milliseconds: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Темпеатура
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              // Column2
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // TODO: Здесь предполагается вставить картинку
                                  Text(
                                    "${data.temp}°C",
                                    style: TextStyle(
                                        fontSize: 44, fontFamily: "Lato"),
                                  ),
                                  Text(
                                      "${data.minTemp}°C / ${data.maxTemp}°C",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: "Lato")),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2, right: 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Влажность: ${data.humidity}%",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "FiraSans")),
                                  Text("Давление: ${data.pressure}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "FiraSans")),
                                  Text(
                                      "Ветер: ${data.windSpeed}(${data.windDeg}°)",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "FiraSans")),
                                  Text("Облака: ${data.clouds}%",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "FiraSans")),
                                ],
                              ),
                            ),
                            //Параметры
                            // Иконка
                          ]))))
        ]));
  }
}
