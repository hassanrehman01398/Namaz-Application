
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'about.dart';
import 'event.dart';
import 'notification.dart';
class DuaPage extends StatefulWidget {
  @override
  DuaPageState createState() => new DuaPageState();
}

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
class DuaPageState extends State<DuaPage> {
  // List tracks = ["one", "track1", "track2", "track3", "track4"]; // note: each track button should now be rendered based on tracks within within Firebase database/Firestore 

  @override
  initState() { 
    super.initState(); 
  }
  
//   onPressed(duaName) async { 
//     var track = await downloadFile(duaName); // should replace track2 with duaName which should be the contents(text) of the button 
//  //  await playTrack(track); 
//   } 

  // Future<void> playTrack(track) async { // may not need to be a future 
  //     AudioPlayer audioPlayer = AudioPlayer();
  //     await audioPlayer.play(track);
  // } 
 String url="";

 Future<String> downloadFile(String duaName) async { 
  //duaName="hassan";
  print("hassan");
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$duaName');
    final StorageReference ref = FirebaseStorage.instance.ref().child('FileType.image/').child('$duaName');
  String  url = await ref.getDownloadURL();
      final http.Response downloadData = await http.get(url);
     var bodyBytes = downloadData.bodyBytes;
    //  Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => VideoPlayerScreen(url: url,title: duaName,)));


     _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Image.memory(
          bodyBytes,
          fit: BoxFit.fill,
        ),
      ),
    );
     print("hussain"+url);
     
   // print("husain"+ref.getDownloadURL().toString());
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    print(downloadTask.toString());
  //  final int byteNumber = (await downloadTask.future).totalByteCount;
 //   return '/data/user/0/thealphamerc.flutter_login_signup/cache/$duaName'; 
return url;
} 

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    // return ListTile(
    //   title:
    //         Card(
    //                 child: RaisedButton(child: Text(document['duaName']),

    //                 color: Colors.green, 
    //                 onPressed: () => onPressed(document['duaName'])), 
    //               )
    // );
  return SingleChildScrollView (
                        child : Center(
                          child: Card(
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                               // print('Tapped on thumbnail.');
                               // print(
                                 //   'Photo doc id: ${document['duaName']}');
                         downloadFile(document['duaName']);
                              },
                              child: Container(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        
                                        Text(document['duaName'],),
                                        ClipRect(
                                          child: Align(
                                              alignment: Alignment.topCenter,
                                              heightFactor: 3.5,
                                              
                                              child: new CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                                
                                                imageUrl: document['duaUrl'],
                                                fit:BoxFit.fill,
                                                
                                              )),
                                              
                                        ),
                                      ])),
                            ),
                          ),
                        ),
                        );
  }

  @override
  Widget build(context) {
    return  Scaffold(
      
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:  Padding(
          padding: const EdgeInsets.all(80.0),
          child: Text("Duas",style: TextStyle(color: Colors.white),),
        ),
      ),
      body: 
        StreamBuilder(
          stream: Firestore.instance.collection("duas").snapshots(),
          builder: (context, snapshot) { 
           if (!snapshot.hasData) return Text("Duas are loading...");
            return GridView.builder(
                itemCount: snapshot.data.documents.length,
               scrollDirection: Axis.vertical,
              
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                       
                itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index])
              );
        }
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

    );
  }
}