import 'package:climator/services/weather.dart';
import 'package:climator/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  const LocationScreen({@required this.weatherData}) ;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int temperature;
  String cityname;
  WeatherModel weatherModel=WeatherModel();
  String weatherIcon,weatherMessage;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherData);
  }
  void updateUI(weatherData){
    setState(() {
      if (weatherData==null){
        temperature=0;
        weatherIcon='Error';
        weatherMessage='unable to get weather data';
        cityname="";
        return;
      }
      temperature=weatherData["main"]["temp"].toInt();
      var condition=weatherData['weather'][0]['id'];
      weatherIcon=weatherModel.getWeatherIcon(condition);
      cityname=weatherData['name'];
      weatherMessage=weatherModel.getMessage(temperature);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData= weatherModel.getWeatherData();
                      updateUI(weatherData);

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedCity=await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (typedCity!=null){
                        var weatherdata= weatherModel.getCityWeather(typedCity);
                        updateUI(weatherdata);
                      }

                    },

                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),

                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
