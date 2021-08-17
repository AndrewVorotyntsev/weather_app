import 'package:weather_app/logic/today_temp_series.dart';
import 'package:weather_app/logic/forecast_temp_series.dart';

class WeatherForecast{
  List<ForecastTempSeries> tempSeries;

  List<TodayTempSeries> mySeries;

  WeatherForecast(this.tempSeries, this.mySeries);

  WeatherForecast.empty() {
    this.tempSeries = [];
  }

}
