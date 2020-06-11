import 'package:flutter/material.dart';
import 'package:namaz/donate.dart';
import 'package:namaz/event.dart';
import 'package:namaz/home.dart';
import 'package:namaz/service.dart';
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Roeyat E Hilal Comite"),
      ),

      body: Container(
        child: Center(child: Text("Settings",style: TextStyle(fontWeight: FontWeight.w900),)),
      ),

      bottomNavigationBar: new BottomAppBar(
        color: Colors.green,
        child: new Container(
//            margin: const EdgeInsets.only(left: 70.0, right: 70.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: new IconButton(
                  icon: new Icon(Icons.home),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeView()));
                  },
                ),
              ),
              Expanded(
                child: new IconButton(
                  icon: new Icon(Icons.event_note),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Event()));
                  },
                ),
              ),

              Expanded(
                child: new IconButton(
                  icon: new Icon(Icons.notifications),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Service()));
                  },
                ),
              ),

              Expanded(
                child: new IconButton(
                  icon: new Icon(Icons.priority_high),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Donate()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
