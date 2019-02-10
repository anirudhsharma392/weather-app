import 'package:flutter/material.dart';

class Changecity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController changecitycontroller = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Wheatherist"),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/white_snow.png',
              width: 600.0,
              height: 1200.0,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(hintText: 'Enter City'),
                  controller: changecitycontroller,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(
                  color: Colors.redAccent,
                  textColor: Colors.white70,
                  onPressed: () {
                    Navigator.pop(
                        context, {'enter': changecitycontroller.text});
                  },
                  child: Text("Get Weather"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
