

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:namaz/calendarpage.dart';
import 'package:namaz/donate.dart';
import 'package:namaz/dua.dart';
import 'package:namaz/event.dart';
import 'package:namaz/home.dart';
import 'package:namaz/notification.dart';
import 'package:namaz/service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:namaz/setting.dart';
import 'about.dart';
import 'bloc/location_bloc/location.dart';
import 'bloc/prayer_time_bloc/prayer_time_state.dart';
import 'contact.dart';
import 'res/colors.dart';
import 'package:hijri/umm_alqura_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/location_bloc/location_bloc_state.dart';
import 'bloc/prayer_time_bloc/prayer_time_bloc.dart';
import 'bloc/prayer_time_bloc/prayer_time_event.dart';
import 'model/user_location_model.dart';
class Home1View extends StatefulWidget {
  @override
  _Home1ViewState createState() => _Home1ViewState();
}

class _Home1ViewState extends State<Home1View> {


    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    
  ummAlquraCalendar selectedDate = new ummAlquraCalendar.now();
  final List<Notification> notifications = [];
   PrayerTimeBloc _prayerTimeBloc;
  LocationBloc _locationBloc;
  UserLocation _location;
  String fajar='';
bool isFetching=false;
List<String> dataList=[];
  @override
  void initState() {
    fajar= getChannelName();    
    super.initState();
   // print(gettiming().toString());
// print("hassan champ");
 // gettiming();

    
     // getGroupsData();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Notification(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: Colors.red,
            ),
          );
        });
      },
      onLaunch: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Notification(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: Colors.green,
            ),
          );
        });
      },
      onResume: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Notification(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: Colors.blue,
            ),
          );
        });
      },
    );
    
    _firebaseMessaging.requestNotificationPermissions();

    
    _prayerTimeBloc = BlocProvider.of<PrayerTimeBloc>(this.context);
    _locationBloc = BlocProvider.of<LocationBloc>(this.context)
      ..listen(
        (state) {
          ///checking for getting coordinates
          if (state is LocationStateDefined) {
            ///when we get coordinates we'll dispatch PrayerTimeBloc
            _prayerTimeBloc
                .add(PrayerTimeFetch(DateTime.now(), state.userLocation));

            ///keep user location
            _location = state.userLocation;
          }
        },
      );
 
    //_firebaseMessaging.subscribeToTopic("all");
    
}
     getGroupsData() {
setState(() {
   isFetching= true;
});

Firestore.instance
    .collection("namaz_timing")
    .getDocuments()
    .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) {

      dataList.add(f.data["timing"].toString());

    });
//forEach
//f.data.values
//for(int j=0;j<5;j++){}



  // print(f.data.toString())
    
    
  //  );
print(dataList.toString());
   setState(() {
      isFetching= false;
   });
  });
}
Stream<namazRecord> gettiming() {
  return Firestore.instance
      .collection("namaz_timing")
      .document("karachi")
      .get()
      .then((snapshot) {
    try {
       return namazRecord.fromSnapshot(snapshot);
    
    } catch (e) {
      print(e);
      return null;
    }
  }).asStream();
}
String getChannelName()  {
 Firestore.instance.collection('namaz_timing').document('karachi').get().then((docSnap) {
   print("hassu");
  print( docSnap['timing1'].toString());
  String channelName = docSnap['timing1'].toString();
  //assert(channelName is String);
  return channelName;
});
  // if (channelName is String) {
  //   return channelName;
  // } else {
  //   throw ......
  // } 
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text("Roeyat E Hilal Comite"),
//       ),
//  body: BlocBuilder(
//         bloc: _locationBloc,
//         builder: (context, state) {
//           if (state is LocationStateInit) {
//             return Center(
//               child: CupertinoActivityIndicator(),
//             );
//           }
//           if (state is LocationStateError) {
//             return Center(
//               child: Text(state.exception.toString()),
//             );
//           }
//            if (state is LocationStateDefined) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   state.userLocation.localName,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 BlocBuilder(
//                   bloc: _prayerTimeBloc,
//                   builder: (context, prayerState) {
//                     if (prayerState is PrayerTimeLoaded) {
//                       return Column(
//                         children: <Widget>[
//                           Card(
//                             child: InkWell(
//                               onTap: () => _showDatePicker(),
//                               child: Padding(
//                                 padding: EdgeInsets.all(8),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.event,
//                                       color: AppColors.qiblaBlue,
//                                       size: ScreenUtil().setHeight(72),
//                                     ),
//                                     Text(
//                                       DateFormat.yMMMMd()
//                                           .format(DateTime.now()),
//                                       style: TextStyle(fontSize: 20),
//                                       textAlign: TextAlign.center,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
         
//       Container(
//         height: 450.0,
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: <Widget>[
//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Fajr'),
//                 subtitle: Center(child: Text('05:30',style: TextStyle(color: Colors.red),)),
//                 leading: Icon(Icons.wb_sunny, color: Colors.grey,),

//               ),
//             ),

//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Zon op'),
//                 leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
//                 subtitle: Center(child: Text('06:30',style: TextStyle(color: Colors.red),)),
//               ),
//             ),
//             Divider(),
//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Zawaal'),
//                 leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
//                 subtitle: Center(child: Text('12:30',style: TextStyle(color: Colors.red),)),
//               ),
//             ),

//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Zohr'),
//                 leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
//                 subtitle: Center(child: Text('13:30',style: TextStyle(color: Colors.red),)),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Asr'),
//                 leading: Icon(Icons.wb_sunny, color: Colors.orange,),
//                 subtitle: Center(child: Text('16:30',style: TextStyle(color: Colors.red),)),
//               ),
//             ),

//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Magrib'),
//                 leading: Icon(Icons.wb_sunny, color: Colors.orange,),
//                 subtitle: Center(child: Text('19:30',style: TextStyle(color: Colors.red),)),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text('Isha'),
//                 leading: Icon(Icons.wb_sunny, color: Colors.grey,),
//                 subtitle: Center(child: Text('21:30',style: TextStyle(color: Colors.red),)),
//               ),
//             ),
//             Divider(),
//             Center(child: Text('dd-mm | hijri-mm')),
//             Center(child: Text('Wiiladat Maulana Noorani',style: TextStyle(color: Colors.red),)),
//             Divider(),
//           ],
//         ),
     
//      ),

//       bottomNavigationBar: new BottomAppBar(
//         color: Colors.green,
//         child: new Container(
// //            margin: const EdgeInsets.only(left: 70.0, right: 70.0),
//           child: new Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Expanded(
//                 child: new IconButton(
//                   icon: new Icon(Icons.home),
//                   iconSize: 50,
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeView()));
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: new IconButton(
//                   icon: new Icon(Icons.event_note),
//                   iconSize: 50,
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => new Event()));
//                   },
//                 ),
//               ),

//               Expanded(
//                 child: new IconButton(
//                   icon: new Icon(Icons.notifications),
//                   iconSize: 50,
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => new Service()));
//                   },
//                 ),
//               ),

//               Expanded(
//                 child: new IconButton(
//                   icon: new Icon(Icons.priority_high),
//                   iconSize: 50,
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => new Donate()));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

 @override
  Widget build(BuildContext context) {
    print(dataList.toString());
    Widget image_coursel = new Container(
        height: 200.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('images/c1.jpg'),
            AssetImage('images/m1.jpg'),
            AssetImage('images/w3.jpg'),
            AssetImage('images/w4.jpg'),
//            AssetImage('images/m2.jpg'),
          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
//        dotSize: 4.0,
//        indicatorBgPadding: 2.0,
        ),
      );
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Roeyat E Hilal Comite',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder(
          bloc: _locationBloc,
          builder: (context, state) {
            if (state is LocationStateInit) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is LocationStateError) {
              return Center(
                child: Text(state.exception.toString()),
              );
            }
            if (state is LocationStateDefined) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  image_coursel,
                  Text(
                    state.userLocation.localName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
               BlocBuilder(
                    bloc: _prayerTimeBloc,
                    builder: (context, prayerState) {
                      if (prayerState is PrayerTimeLoaded) {
                        return Column(
                          children: <Widget>[
                           // image_coursel,
                            Card(
                              child: InkWell(
                                onTap: () => _selectDate(context),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.event,
                                        color: AppColors.qiblaBlue,
                                        size: ScreenUtil().setHeight(72),
                                      ),
                                      Text(
                                        '${selectedDate.fullDate()}',
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,

                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: InkWell(
                                onTap: () {
                                 Navigator.push(
                             context,
                        MaterialPageRoute(builder: (context) => CalendarPage(title:"Calendar"),
                                 ));
  }
                                ,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 80.0,right: 80.0,top: 8.0,bottom: 8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.event,
                                        color: AppColors.qiblaBlue,
                                        size: ScreenUtil().setHeight(72),
                                      ),
                                      Text(
                                        DateFormat.yMMMMd()
                                            .format(DateTime.now()),
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,

                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text('Sunrise'),
                                              Icon(Icons.wb_sunny,color: Colors.orange,),
                                              Text(
                                                prayerState.model.sunrise,
                                                style: TextStyle(
                                                    color: Colors.orangeAccent),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[

                  // leading: Icon(Icons.wb_sunny, color: Colors.orangeAccent,),
                                              Text('Sunset'),
                                              Icon(Icons.wb_sunny,color: Colors.grey,),
                                              Text(
                                                prayerState.model.sunset,
                                                style: TextStyle(
                                                    color: Colors.orangeAccent),

                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(Icons.wb_sunny,color: Colors.grey,),
                                            Text("Fajr"),


                                            Text(
                                              gettiming().elementAt(0).toString(),
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            ),

                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Icon(Icons.wb_sunny,color: Colors.orangeAccent,),
                                            ),
                                            Text("Dhuhr"),


                                            Text(
                                             gettiming().elementAt(0).toString(),
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            ),

                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right:2.0),
                                              child: Icon(Icons.wb_sunny,color: Colors.orangeAccent,),
                                            ),
                                            Text("Asr"),


                                            Text(
                                           gettiming().elementAt(0).toString(),
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            ),

                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left:9.0),
                                              child: Icon(Icons.wb_sunny,color: Colors.orangeAccent,),
                                            ),
                                            Text("Maghrib"),


                                            Text(
                                     gettiming().first.toString(),
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            ),

                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(Icons.wb_sunny,color: Colors.orangeAccent,),
                                            Text("Isha"),


                                            Text(
                                            
                                     fajar ,
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      } else if (prayerState is PrayerTimeError) {
                        return Text('something went wrong');
                      } else
                        return CupertinoActivityIndicator();
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(200),
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              );
            }
            return null;
          },
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
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeView()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new Notification1()));
                },
              ),
            ),

            Expanded(
              child: new IconButton(
                icon: new Icon(Icons.priority_high),
                iconSize: 50,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new AboutTab()));
                },
              ),
            ),
          ],
        ),
      ),
      ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              Container(
                height: 120.0,
                color: Colors.green,
                child: Center(child: Text("Roeyat E Hilal Comite",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20.0),)),
              ),
              // body
//              InkWell(
//                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => new Donate()));
//                },
//                child: ListTile(
//                  title: Text('Donate'),
//                  leading: Icon(Icons.accessibility, color: Colors.black,),
//                ),
//              ),

              InkWell(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeView()));
                },
                child: ListTile(
                  title: Text('Home',style: TextStyle(color: Colors.green),),
                  leading: Icon(Icons.home, color: Colors.green,),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new Event()));
                },
                child: ListTile(
                  title: Text('Events',style: TextStyle(color: Colors.green),),
                  leading: Icon(Icons.event, color: Colors.green,),
                ),
              ),

              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => new Service()));
              //   },
              //   child: ListTile(
              //     title: Text('Services'),
              //     leading: Icon(Icons.event_note, color: Colors.black,),
              //   ),
              // ),



              InkWell(
                onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => DuaPage()));

                },
                child: ListTile(
                  title: Text('Duas',style: TextStyle(color: Colors.green),),
                  leading: Icon(Icons.star_half, color: Colors.green,),
                ),
              ),

              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //     title: Text('Subscribe to Newsletters'),
              //     leading: Icon(
              //       Icons.notifications_active, color: Colors.black,),
              //   ),
              // ),

              InkWell(
                onTap: () {
 Navigator.push(context, MaterialPageRoute(builder: (context) => Notification1()));


                },
                child: ListTile(
                  title: Text('Announcements',style: TextStyle(color: Colors.green),),
                  leading: Icon(Icons.message, color: Colors.green,),
                ),
              ),
              Divider(color: Colors.green,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new AboutTab()));


                },
                child: ListTile(
                  title: Text('About Us'),
                  leading: Icon(Icons.account_box, color: Colors.black,),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new ContactTab()));


                },
                child: ListTile(
                  title: Text('Contact Us'),
                  leading: Icon(Icons.mail, color: Colors.black,),
                ),
              ),

              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //     title: Text('Business Directory'),
              //     leading: Icon(Icons.assignment, color: Colors.black,),
              //   ),
              // ),

              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => new Setting()));
              //   },
              //   child: ListTile(
              //     title: Text('Settings'),
              //     leading: Icon(Icons.settings, color: Colors.black,),
              //   ),
         //     ),
            ],
          ),
        ),
    );
  }

  // void _showDatePicker() {
  //   print("hassan");
  //   //     DatePicker.showDatePicker(this.context,
  //   //     pickerTheme: DateTimePickerTheme(
  //   //       backgroundColor: AppColors.neutral,
  //   //       confirm: Icon(Icons.check, color: AppColors.qiblaBlue),
  //   //       cancel: Icon(
  //   //         Icons.clear,
  //   //         color: Colors.orangeAccent,
  //   //       ),
  //   //     ),
  //   //     initialDateTime: DateTime.now(), onConfirm: (day, List<int> index) {
  //   //   _prayerTimeBloc.add(PrayerTimeFetch(day, _location));
  //   // });
 
 
  // }
  
  Future<Null> _selectDate(BuildContext context) async {
    final ummAlquraCalendar picked = await showHijriDatePicker(
      context: context,
    //  events:,

      initialDate: selectedDate,
      lastDate: new ummAlquraCalendar()
        ..hYear = 1442
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new ummAlquraCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    
    print(picked);
    if (picked != null) setState(() {
      selectedDate = picked;
    });
  }
}


 Widget buildNotification(Notification notification) {
    return ListTile(
      title: Text(
        notification.title,
        style: TextStyle(
          color: notification.color,
        ),
      ),
      subtitle: Text(notification.body),
    );
  }

class Notification {
  final String title;
  final String body;
  final Color color;
  const Notification(
      {@required this.title, @required this.body, @required this.color});
}
/*

void _showDatePicker() {
    DatePicker.showDatePicker(context,
        pickerTheme: DateTimePickerTheme(
          backgroundColor: AppColors.neutral,
          confirm: Icon(Icons.check, color: AppColors.qiblaBlue),
          cancel: Icon(
            Icons.clear,
            color: Colors.orangeAccent,
          ),
        ),
        initialDateTime: DateTime.now(), onConfirm: (day, List<int> index) {
      _prayerTimeBloc.add(PrayerTimeFetch(day, _location));
    });
  }
*/
// List<String> gettiming1;
class namazRecord {
  // Header members
  String timing1="",timing2="",timing3="",timing4="",timing5="";
  // String name;
  // int creationTimestamp;
  // List<int> ratings = new List<int>();
  // List<String> players = new List<String>();
  // GameReview gameReview;

  namazRecord.fromSnapshot(DocumentSnapshot snapshot)
      : 
        timing1 = snapshot['timing1'],
        timing2 = snapshot['timing2'],
        timing3 = snapshot['timing3'],
        timing4 = snapshot['timing4'],
        timing5= snapshot['timing5'];
  // List<String> get_timing(){

  //   gettiming1.add(timing1);
  //   gettiming1.add(timing2);
  //   gettiming1.add(timing3);
  //   gettiming1.add(timing4);
  //   gettiming1.add(timing5);
  //   return gettiming1;
  // }
      
String gettiming1(){

  return timing1;
}
String gettiming2(){

  return timing2;
}String gettiming3(){

  return timing3;
}String gettiming4(){

  return timing4;
}String gettiming5(){

  return timing5;
}

}