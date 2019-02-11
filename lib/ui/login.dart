import 'package:flutter/material.dart';
import './register.dart';
import './weatherpage.dart';
import './changecity.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Loginstate();
  }
}

class Loginstate extends State<Login> {
  String username = 'user';
  String password = 'pass';
  String city;
  String name;
  String display = '';
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  Future _gotoregister(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return Register();
    }));
    username = results['username'].toString();
    password = results['password'].toString();
    name = results['name'].toString();
    city = results['city'].toString();
  }

  void _gotoweatherist() {
    var router = MaterialPageRoute(builder: (BuildContext context) {
      return Weatherist();
    });
    Navigator.of(context).push(router);
  }

  void _clear() {
    setState(() {
      _username.clear();
      _password.clear();
    });
  }

  void _login() {
    setState(() {
      if (_username.text.isEmpty || _password.text.isEmpty) {
        display = "Please, fill up the Above Fields first";
      } else if (_username.text != username) {
        display = "Username does not match";
      } else if (_password.text != password) {
        display = "Password does not match";
      } else {
        _gotoweatherist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/login.jpg',
              width: 600.0,
              height: 1200.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            alignment: Alignment.topCenter,
            child: ListView(
              children: <Widget>[
                Image.asset(
                  "images/face.png",
                  width: 90.0,
                  height: 90.0,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 4.0),
                      borderRadius: BorderRadius.all(Radius.circular(
                              25.0) //                 <--- border radius here
                          ),
                    ),
                    margin: EdgeInsets.only(top: 70.0, left: 30.0, right: 40.0),
                    height: 120.0,
                    width: 360.0,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _username,
                          decoration: InputDecoration(
                              hintText: "Username",
                              icon: new Icon(Icons.person)),
                        ),
                        TextField(
                          controller: _password,
                          decoration: InputDecoration(
                              hintText: "Password", icon: new Icon(Icons.lock)),
                          obscureText: true,
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 70.0),
                          child: RaisedButton(
                            onPressed: _login,
                            color: Colors.redAccent,
                            child: Text(
                              'login',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.9),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 100.0),
                          child: RaisedButton(
                            onPressed: _clear,
                            color: Colors.redAccent,
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.9),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: <Widget>[
                      Text("$display",
                          style: TextStyle(fontSize: 20.0, color: Colors.pink))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    child: RaisedButton(
                      onPressed: () {
                        _gotoregister(context);
                      },
                      color: Colors.blueAccent,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 16.9),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
