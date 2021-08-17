import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/widgets/SearchCity.dart';
import 'package:weather_app/widgets/cards/WeatherTodayCard.dart';
import 'package:weather_app/widgets/cards/WeatherNowCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherAppState();
  }
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Скрывает метку debug с правого верхнего угла
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffb0c4de),
        appBar: AppBar(
          title: Text("Погода"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: BlocProvider(
            create: (BuildContext context) =>
                WeatherBloc(),//..add(FetchWeatherEvent("Елец")),
            child: Column(
              children: [
              SearchCity(),

              BlocBuilder<WeatherBloc, WeatherModel>(
                  builder: (BuildContext context, state) {
                if (state.currentWeather.city == null) {
                  return Center();
                } else {
                  return WeatherNowCard(data: state.currentWeather);
                }
              }),

              BlocBuilder<WeatherBloc, WeatherModel>(
                  builder: (BuildContext context, state) {
                    if (state.currentWeather.city == null) {
                      return Center();
                    } else {
                      return WeatherTodayCard(data: state.weatherForecast);
                    }
                  }),

              //WeatherTodayCard()
            ]),
          ),
        ),
      ),
    );
  }
}
