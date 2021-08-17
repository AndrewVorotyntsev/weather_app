import 'dart:convert';

import 'package:weather_app/logic/today_temp_series.dart';
import 'package:weather_app/logic/forecast_temp_series.dart';

import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/weather_forecast.dart';

import 'package:http/http.dart' as http;

class WeatherFetcher {

  String _token;

  Future<WeatherModel> fetchWeather(String city) async {

    CurrentWeather weatherNow = await _fetchWeatherNow(city);

    WeatherForecast weatherToday = await _fetchWeatherForecast(city);

    WeatherModel weatherModel = WeatherModel(weatherNow, weatherToday);

    return weatherModel;
  }

  Future<CurrentWeather> _fetchWeatherNow(String city) async {
    String weatherNowLink =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_token&lang=ru";
    http.Response response = await http.get(weatherNowLink);
    var resultWeather = jsonDecode(response.body);


    CurrentWeather weatherNowModel = CurrentWeather(
        city,
        resultWeather["main"]["temp"].toDouble(),
        resultWeather["main"]["temp_min"].toDouble(),
        resultWeather["main"]["temp_max"].toDouble(),
        resultWeather["main"]["humidity"].toDouble(),
        resultWeather["main"]["pressure"].toDouble(),
        resultWeather["wind"]["speed"].toDouble(),
        resultWeather["wind"]["deg"].toDouble(),
        resultWeather["clouds"]["all"].toDouble(),
        resultWeather["weather"][0]["main"]);

    return weatherNowModel;

  }

  Future<WeatherForecast> _fetchWeatherForecast(String city) async {
    String weatherNowLink = "https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$_token&lang=ru";
    http.Response response = await http.get(weatherNowLink);
    var resultWeather = jsonDecode(response.body);

    List<ForecastTempSeries> forecastTempSeries = [];

    for(int i =0;  i < 40; i++) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(resultWeather["list"][i]["dt"] * 1000);
      forecastTempSeries.add(
        ForecastTempSeries(
          time: dateTime,
          temperature: resultWeather["list"][i]["main"]["temp"].toDouble(),
        )
      );
    }

    List<TodayTempSeries> todayTempSeries = [];

    int prevTime = 0;

    String timeLabel = "";

    for(int i = 0;  i < 8; i++) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(resultWeather["list"][i]["dt"] * 1000);
      if (dateTime.hour > prevTime) {
        timeLabel = "${dateTime.hour}:${dateTime.minute}";
      } else {
        timeLabel = "${dateTime.day}.${dateTime.month}";
      }
      prevTime = dateTime.hour;
      todayTempSeries.add(
          TodayTempSeries(
            time: timeLabel,
            temperature: resultWeather["list"][i]["main"]["temp"].toInt(),
          )
      );
    }

    WeatherForecast weatherToday = WeatherForecast(forecastTempSeries, todayTempSeries);

    return weatherToday;
  }

}
