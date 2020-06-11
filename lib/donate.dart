import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:namaz/event.dart';
import 'package:namaz/home.dart';
import 'package:namaz/service.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Roeyat E Hilal Comite"),
      ),

      body: Container(
        height: 450.0,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(10.0),),
            ButtonTheme(
              minWidth: 150.0,
              height: 50.0,
              child: RaisedButton(
                child: Text("Madarsa fees",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                color: Colors.grey,
                onPressed: (){},
              ),
            ),
            Padding(padding: const EdgeInsets.all(10.0),),
            ButtonTheme(
              minWidth: 150.0,
              height: 50.0,
              child: RaisedButton(
                child: Text("Fitra",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                color: Colors.green,
                onPressed: (){},
              ),
            ),
            Padding(padding: const EdgeInsets.all(10.0),),
            ButtonTheme(
              minWidth: 150.0,
              height: 50.0,
              child: RaisedButton(
                child: Text("Fitra",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                color: Colors.purpleAccent,
                onPressed: (){},
              ),
            ),
            Padding(padding: const EdgeInsets.all(10.0),),
        ButtonTheme(
          minWidth: 150.0,
          height: 50.0,
          child: RaisedButton(
            child: Text("Sadqa",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
            color: Colors.redAccent,
            onPressed: (){},
          ),
        ),
            Padding(padding: const EdgeInsets.all(10.0),),
        ButtonTheme(
          minWidth: 150.0,
          height: 50.0,
          child: RaisedButton(
            child: Text("Construction",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
            color: Colors.blue,
            onPressed: (){},
          ),
        ),
            Padding(padding: const EdgeInsets.all(10.0),),
        ButtonTheme(
          minWidth: 150.0,
          height: 50.0,
          child: RaisedButton(
            child: Text("Zakat",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
            color: Colors.pinkAccent,
            onPressed: (){},
          ),
           ),
          ],
        ),
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
