import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import '../bloc/weather_events.dart';

class SearchCity extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Row(
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
              controller: _controller,
              style: TextStyle(fontSize: 20),
              //onChanged: () {},
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
            onPressed: () => context.read<WeatherBloc>().add(FetchWeatherEvent(_controller.text)),
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
        ),
      ],
    );
  }
}
