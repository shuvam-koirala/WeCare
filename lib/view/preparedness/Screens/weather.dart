import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var temp;
  var description;
  var icon;
  var location;
  var windDir;
  var windspeed;
  var humidity;
  var time;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.weatherapi.com/v1/current.json?key= 5b7501f1b9194ad5a7c104420200808&q=Itahari");
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['current']['temp_c'];
      this.description = results['current']['condition']['text'];
      this.location = results['location']['name'];
      this.windspeed = results['current']['wind_kph'];
      this.humidity = results['current']['humidity'];
      this.time = results['location']['localtime'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      location != null ? location.toString() : " Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    temp != null ? temp.toString() + "\u00b0C" : " Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      time != null ? time : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("temperature"),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u00b0C"
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("weather"),
                      trailing: Text(
                        description != null
                            ? description.toString()
                            : "Loading",
                      ),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.solidSun),
                      title: Text("humidity"),
                      trailing: Text(
                        humidity != null ? humidity.toString() : "Loading",
                      ),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("wind speed"),
                      trailing: Text(
                        windspeed != null ? windspeed.toString() : "Loading",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
