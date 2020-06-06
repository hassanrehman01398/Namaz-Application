import 'package:flutter/material.dart';
import 'package:namaz/donate.dart';
import 'package:namaz/event.dart';
import 'package:namaz/service.dart';
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                title: Text('Fajr'),
                subtitle: Center(child: Text('05:30',style: TextStyle(color: Colors.red),)),
                leading: Icon(Icons.wb_sunny, color: Colors.grey,),

              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Zon op'),
                leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
                subtitle: Center(child: Text('06:30',style: TextStyle(color: Colors.red),)),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Zawaal'),
                leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
                subtitle: Center(child: Text('12:30',style: TextStyle(color: Colors.red),)),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Zohr'),
                leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
                subtitle: Center(child: Text('13:30',style: TextStyle(color: Colors.red),)),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Asr'),
                leading: Icon(Icons.wb_sunny, color: Colors.orange,),
                subtitle: Center(child: Text('16:30',style: TextStyle(color: Colors.red),)),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Magrib'),
                leading: Icon(Icons.wb_sunny, color: Colors.orange,),
                subtitle: Center(child: Text('19:30',style: TextStyle(color: Colors.red),)),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Isha'),
                leading: Icon(Icons.wb_sunny, color: Colors.grey,),
                subtitle: Center(child: Text('21:30',style: TextStyle(color: Colors.red),)),
              ),
            ),
            Divider(),
            Center(child: Text('dd-mm | hijri-mm')),
            Center(child: Text('Wiiladat Maulana Noorani',style: TextStyle(color: Colors.red),)),
            Divider(),
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
