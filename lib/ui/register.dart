import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  String name;
  Register({Key key, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Registerstate();
  }
}

class Registerstate extends State<Register> {
  String username;
  String password;
  String display = '';
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _city = new TextEditingController();

  void _clear() {
    setState(() {
      _username.clear();
      _password.clear();
      _name.clear();
      _city.clear();
    });
  }

  void _register() {
    setState(() {
      if (_username.text.isEmpty ||
          _password.text.isEmpty ||
          _name.text.isEmpty ||
          _city.text.isEmpty) {
        display = "Please, fill up the Above Fields first";
      } else if (_username.text.length < 3) {
        display = "Username is too short";
      } else if (_password.text.length < 3) {
        display = "password is too short";
      } else {
        Navigator.pop(context, {
          'username': _username.text,
          'password': _password.text,
          'name': _name.text,
          'city': _city.text
        });
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
      body: Stack(children: <Widget>[
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
                "images/reg.png",
                width: 120.0,
                height: 120.0,
              ),
              Opacity(
                opacity: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 4.0),
                    borderRadius: BorderRadius.all(Radius.circular(
                            25.0) //                 <--- border radius here
                        ),
                  ),
                  margin: EdgeInsets.only(top: 70.0, left: 30.0, right: 40.0),
                  height: 220.0,
                  width: 200.0,
                  child: ListView(
                    children: <Widget>[
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                            hintText: "Name",
                            icon: new Icon(Icons.person_outline)),
                      ),
                      TextField(
                        controller: _username,
                        decoration: InputDecoration(
                            hintText: "Username",
                            icon: new Icon(Icons.mail_outline)),
                      ),
                      TextField(
                        controller: _password,
                        decoration: InputDecoration(
                            hintText: "Password", icon: new Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      TextField(
                        controller: _city,
                        decoration: InputDecoration(
                            hintText: "Your City", icon: new Icon(Icons.home)),
                      ),
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
                          onPressed: _register,
                          color: Colors.blueAccent,
                          child: Text(
                            'Register',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.9),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 100.0),
                        child: RaisedButton(
                          onPressed: _clear,
                          color: Colors.redAccent,
                          child: Text(
                            'Clear',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.9),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70.0),
                child: Column(
                  children: <Widget>[
                    Text("$display",
                        style: TextStyle(fontSize: 20.0, color: Colors.pink))
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
