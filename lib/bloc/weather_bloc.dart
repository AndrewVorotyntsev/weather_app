
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/weather_forecast.dart';

import 'weather_events.dart';
import 'package:weather_app/logic/weather_fetcher.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherModel> {
  /// {@macro counter_bloc}
  WeatherBloc() : super(WeatherModel(CurrentWeather.empty(), WeatherForecast.empty()));


  @override
  Stream<WeatherModel> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      WeatherFetcher weatherFetcher = WeatherFetcher();
      yield await weatherFetcher.fetchWeather(event.city);
    }
  }

}