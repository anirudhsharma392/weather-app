import 'dart:async';
import 'dart:convert';
import './changecity.dart';

import 'package:flutter/material.dart';
import '../util/util.dart' as util;
import 'package:http/http.dart' as http;

class Weatherist extends StatefulWidget {
  @override
  WeatheristState createState() => WeatheristState();
}

class WeatheristState extends State<Weatherist> {
  String currentcity;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onbackpressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Weatherist"),
            centerTitle: true,
            backgroundColor: Colors.red,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  callchangecity(context);
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/umbrella.png',
                  width: 600.0,
                  height: 1200.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Text(
                    '${currentcity == null ? util.defaultcity : currentcity}',
                    style: citystyle()),
                alignment: Alignment.topRight,
                margin: EdgeInsets.fromLTRB(0, 30, 20, 0),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 50, 0, 0),
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'images/light_rain.png',
                ),
              ),
              Container(
                child: updatetemp(currentcity),
              ),
            ],
          ),
        ));
  }

/////////////////////////////////FUNCTIONS/////////////////////////

  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to Logout?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () => Navigator.pop(context, true),
                )
              ],
            ));
  }

  Future<Map> getweather(String appid, String city) async {
    String apiurl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=${util.appid}';

    http.Response response = await http.get(apiurl);
    return json.decode(response.body);
  }

  Widget updatetemp(String city) {
    return FutureBuilder(
      future: getweather(util.appid, city == null ? util.defaultcity : city),
      builder: (BuildContext, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return Container(
            margin: EdgeInsets.fromLTRB(30.0, 260.0, 140, 0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    " ${content['main']['temp'].toString()}°C ",
                    style: tempstyle(),
                  ),
                  subtitle: ListTile(
                      title: Text(
                    " \n Min:${content['main']['temp_min'].toString()}°C \n Max:${content['main']['temp_max'].toString()}°C Humidity:${content['main']['humidity'].toString()}% \n Wind:${content['wind']['speed'].toString()}m/s ",
                    style: hightempstyle(),
                  )),
                ),
              ],
            ),
            alignment: Alignment.center,
          );
        } else {
          debugPrint("nothing");
        }
      },
    );
  }

  Future callchangecity(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return Changecity();
    }));

    if (results != null && results.containsKey('enter')) {
      currentcity = results['enter'];
    } else {
      debugPrint("nothing");
    }
  }
/////////////////////////////////FUNCTIONS/////////////////////////

////////////////////////////////STYLES////////////////////////
  TextStyle citystyle() {
    return TextStyle(
        color: Colors.white, fontSize: 35.0, fontStyle: FontStyle.italic);
  }

  TextStyle hightempstyle() {
    return TextStyle(
        fontWeight: FontWeight.w300,
        color: Colors.white70,
        fontSize: 25.0,
        fontStyle: FontStyle.normal);
  }

  TextStyle tempstyle() {
    return TextStyle(
        fontWeight: FontWeight.w200,
        color: Colors.white,
        fontSize: 60.0,
        fontStyle: FontStyle.normal);
  }
}
////////////////////////////////STYLES////////////////////////
