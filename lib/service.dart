import 'package:flutter/material.dart';
import 'package:namaz/donate.dart';
import 'package:namaz/event.dart';
import 'package:namaz/home.dart';

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
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
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Friday Prayers'),
                subtitle: Center(child: Text('Join us for Juma prayers every Friday at 1:30 pm',style: TextStyle(color: Colors.black54),)),
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
