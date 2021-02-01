import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _WeatherAppState();
  }
}

class _WeatherAppState extends State<WeatherApp>{

  // В планах добавить отлов ошибок при отсутствии подключения к интернету и в опечатках

  // Во время отдадки оставляем 1.0
  //double opacityLevel = 1.0;
  // При запуске приложения карточка с погодой не имеет данных, поэтому мы ее не показываем
  double opacityLevel = 0.0;
  var title = "Погода";

  var city;

  var temp;
  var temp_min;
  var temp_max;

  var humidity;
  var pressure;

  var wind_speed;
  var wind_deg;

  var clouds;

  var description;

  Future getWeather () async {
    //Прогноз  на 5 дней
    String token = "My token";
    String weatherLink = "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$token&lang=ru";
    http.Response response = await http.get(weatherLink);
    var resultWeather = jsonDecode(response.body);

    setState(() {
      temp = resultWeather["main"]["temp"];
      temp_min = resultWeather["main"]["temp_min"];
      temp_max = resultWeather["main"]["temp_max"];

      humidity = resultWeather["main"]["humidity"];
      pressure = resultWeather["main"]["pressure"];

      wind_speed = resultWeather["wind"]["speed"];
      wind_deg = resultWeather["wind"]["deg"];

      clouds = resultWeather["clouds"]["all"];


      description = resultWeather["weather"][0]["main"];

      // Меняем заголовок и делаем карточку видимой
      title = "Погода в городе $city";
      opacityLevel = 1.0;
    });

  }


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
          backgroundColor:Color(0xffb0c4de),
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          body: Container(
              margin: EdgeInsets.all(10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Row1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 310,
                            //height: 50,
                            //margin: EdgeInsets.only(left: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 20),
                                onChanged: (String str){
                                  setState(() {
                                    city = str;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Введите город",
                                  //contentPadding: EdgeInsets.only(left: 10),
                                  icon: Icon(Icons.search_sharp),
                                ),
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                              ),
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.all(2),
                            width: 42,
                            height: 42,
                            child: RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  // При запросе данных старые данные скорее всего будут неактуальны
                                  // Поэтому мы делаем видимость того, что старая карточка с погодой исчезает, а затем появляется новая
                                  opacityLevel = 0.0;
                                });
                                getWeather();
                              },
                              //elevation: 1.0,
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.cloud_sharp,
                                color: Colors.blue,
                                size: 25.0,
                              ),
                              //padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                          )
                        ],
                      ),
                    // Row1
                    AnimatedOpacity(opacity: opacityLevel, duration : Duration(milliseconds: 100),child:
                    Row(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Темпеатура
                                  Padding(padding: EdgeInsets.only(right: 5),
                                  // Column2
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Здесь предполагается вставить картинку, но на даннный момент их нельзя загружать из сети
                                      Text("$temp°C", style: TextStyle(fontSize: 44, fontFamily: "Lato"),),
                                      Text("$temp_min°C / $temp_max°C", style: TextStyle(fontSize: 18, fontFamily: "Lato")),
                                    ],
                                  ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Влажность: $humidity%", style: TextStyle(fontSize: 20, fontFamily: "FiraSans")),
                                      Text("Давление: $pressure кПа", style: TextStyle(fontSize: 20, fontFamily: "FiraSans")),
                                      Text("Ветер: $wind_speed($wind_deg°)", style: TextStyle(fontSize: 20, fontFamily: "FiraSans")),
                                      Text("Облака: $clouds%", style: TextStyle(fontSize: 20, fontFamily: "FiraSans")),
                                    ],
                                  ),
                                  ),
                                  //Параметры
                                  // Иконка
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                    )],
                ),
              ),
          ),
    );
  }

}
