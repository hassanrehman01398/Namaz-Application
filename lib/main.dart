//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz/donate.dart';
import 'package:namaz/event.dart';
import 'package:namaz/home.dart';
import 'package:namaz/res/colors.dart';
import 'package:namaz/service.dart';
import 'package:namaz/setting.dart';

import 'bloc/location_bloc/location_bloc.dart';
import 'bloc/prayer_time_bloc/prayer_time_bloc.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>(
            create: (BuildContext context) =>
                LocationBloc()..add(LocationEvent.fetchLocation),
          ),
          BlocProvider<PrayerTimeBloc>(
            create: (BuildContext context) => PrayerTimeBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: AppColors.neutral,
              highlightColor: Colors.transparent,
              textTheme: TextTheme(
                  body1: TextStyle(
                    color: Colors.black54,
                  ),
                  title: TextStyle(
                    color: Colors.black54,
                  )),
              primaryTextTheme:
                  TextTheme(title: TextStyle(color: Colors.black54)),
              appBarTheme: AppBarTheme(elevation: 0, color: Colors.grey[50])),
                home: HomeView(),
   ),
      ),
    );
  });
}



// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//       Widget image_coursel = new Container(
//         height: 200.0,
//         child: new Carousel(
//           boxFit: BoxFit.cover,
//           images: [
//             AssetImage('images/c1.jpg'),
//             AssetImage('images/m1.jpg'),
//             AssetImage('images/w3.jpg'),
//             AssetImage('images/w4.jpg'),
// //            AssetImage('images/m2.jpg'),
//           ],
//           autoplay: true,
//           animationCurve: Curves.fastOutSlowIn,
//           animationDuration: Duration(milliseconds: 1000),
// //        dotSize: 4.0,
// //        indicatorBgPadding: 2.0,
//         ),
//       );

//       return new Scaffold(
//         appBar: new AppBar(
//           title: new Text("Roeyat E Hilal Comite"),
//           actions: <Widget>[
//             new IconButton(icon: Icon(Icons.settings),
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Setting()));
//                 }),
//           ],
//         ),

//         body: new ListView(
//             children: <Widget>[
//               image_coursel,
//               new Padding(padding: const EdgeInsets.all(8.0),
//                 child: Center(child: new Text('DATE | HIJRI DATE CITY',style: TextStyle(fontWeight: FontWeight.w900),)),
//               ),
//               Divider(),
//               Container(
//                 height: 250.0,
//                 child: ListView(
//                   scrollDirection: Axis.vertical,
//                   children: <Widget>[
//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Fajr'),
//                         subtitle: Center(child: Text('05:30',style: TextStyle(color: Colors.red),)),
//                         leading: Icon(Icons.wb_sunny, color: Colors.grey,),

//                       ),
//                     ),

//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Zon op'),
//                         leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
//                         subtitle: Center(child: Text('06:30',style: TextStyle(color: Colors.red),)),
//                       ),
//                     ),
//                     Divider(),
//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Zawaal'),
//                         leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
//                         subtitle: Center(child: Text('12:30',style: TextStyle(color: Colors.red),)),
//                       ),
//                     ),

//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Zohr'),
//                         leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
//                         subtitle: Center(child: Text('13:30',style: TextStyle(color: Colors.red),)),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Asr'),
//                         leading: Icon(Icons.wb_sunny, color: Colors.orange,),
//                         subtitle: Center(child: Text('16:30',style: TextStyle(color: Colors.red),)),
//                       ),
//                     ),

//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Magrib'),
//                         leading: Icon(Icons.wb_sunny, color: Colors.orange,),
//                         subtitle: Center(child: Text('19:30',style: TextStyle(color: Colors.red),)),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: ListTile(
//                         title: Text('Isha'),
//                         leading: Icon(Icons.wb_sunny, color: Colors.grey,),
//                         subtitle: Center(child: Text('21:30',style: TextStyle(color: Colors.red),)),
//                       ),
//                     ),
//                     Divider(),
//                     Center(child: Text('dd-mm | hijri-mm')),
//                     Center(child: Text('Wiiladat Maulana Noorani',style: TextStyle(color: Colors.red),)),
//                     Divider(),
//                   ],
//                 ),
//               ),
//             ],
//         ),

//         bottomNavigationBar: new BottomAppBar(
//           color: Colors.green,
//           child: new Container(
// //            margin: const EdgeInsets.only(left: 70.0, right: 70.0),
//         child: new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Expanded(
//               child: new IconButton(
//                 icon: new Icon(Icons.home),
//                 iconSize: 50,
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeView()));
//                 },
//               ),
//             ),
//             Expanded(
//               child: new IconButton(
//                 icon: new Icon(Icons.event_note),
//                 iconSize: 50,
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Event()));
//                 },
//               ),
//             ),

//             Expanded(
//               child: new IconButton(
//                 icon: new Icon(Icons.notifications),
//                 iconSize: 50,
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Service()));
//                 },
//               ),
//             ),

//             Expanded(
//               child: new IconButton(
//                 icon: new Icon(Icons.priority_high),
//                 iconSize: 50,
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Donate()));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       ),
//         drawer: new Drawer(
//           child: new ListView(
//             children: <Widget>[
//               // body
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Donate()));
//                 },
//                 child: ListTile(
//                   title: Text('Donate'),
//                   leading: Icon(Icons.accessibility, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeView()));
//                 },
//                 child: ListTile(
//                   title: Text('Home'),
//                   leading: Icon(Icons.home, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Event()));
//                 },
//                 child: ListTile(
//                   title: Text('Events'),
//                   leading: Icon(Icons.event, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Service()));
//                 },
//                 child: ListTile(
//                   title: Text('Services'),
//                   leading: Icon(Icons.event_note, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {},
//                 child: ListTile(
//                   title: Text('About Us'),
//                   leading: Icon(Icons.account_box, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {},
//                 child: ListTile(
//                   title: Text('Contact Us'),
//                   leading: Icon(Icons.mail, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {},
//                 child: ListTile(
//                   title: Text('Duas'),
//                   leading: Icon(Icons.star_half, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {},
//                 child: ListTile(
//                   title: Text('Subscribe to Newsletters'),
//                   leading: Icon(
//                     Icons.notifications_active, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {},
//                 child: ListTile(
//                   title: Text('Announcements'),
//                   leading: Icon(Icons.message, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {},
//                 child: ListTile(
//                   title: Text('Business Directory'),
//                   leading: Icon(Icons.assignment, color: Colors.black,),
//                 ),
//               ),

//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new Setting()));
//                 },
//                 child: ListTile(
//                   title: Text('Settings'),
//                   leading: Icon(Icons.settings, color: Colors.black,),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }

