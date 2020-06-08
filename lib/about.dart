import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:namaz/config/assets.dart';
import 'package:namaz/config/constants.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage: Image.asset(Assets.hassan).image,
              ),
              //SizedBox(
                //height: 20,
              //),
              //Text(
             //   'Muhammad Hasan Ur Rehman',
           //     textScaleFactor: 4,
         //     ),
              //SizedBox(
               // height: 20,
              //),
              Text(
                  'Android. Flutter. Dotnet. Python. Web. Desktop Applications. Cricket. Music.\nLikes Traveling.',
                  //style: Theme.of(context).textTheme.button,
                  textScaleFactor: .5,
                  textAlign: TextAlign.center,
                ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.github)),
                    label: Text('Github'),
                    
                    onPressed:_launchgithub,// html.window.open(Constants.PROFILE_GITHUB,'Hasan Rehman' ),
                  ),
                  // ),FlatButton.icon(
                  //   icon: SizedBox(
                  //       width: 20,
                  //       height: 20,
                  //       child: Image.asset(Assets.twitter)),
                  //   label: Text('Twitter'),
                  //   onPressed:()=> html.window.open(Constants.PROFILE_TWITTER,'Hasan Rehman' ),
                  // ),
                  // FlatButton.icon(
                  //   icon: SizedBox(
                  //       width: 20,
                  //       height: 20,
                  //       child: Image.asset(Assets.medium)),
                  //   label: Text('Medium'),
                  //   onPressed:()=> html.window.open(Constants.PROFILE_MEDIUM,'Hasan Rehman' ),
                  // )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.instagram)),
                    label: Text('Instagram'),
                    onPressed: _launchinsta,
                  ),FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.facebook)),
                    label: Text('Facebook'),
                    onPressed:_launchfacebook,
                  ),FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.linkedin)),
                    label: Text('Linkedin'),
                    onPressed:_launchlinklen,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
_launchgithub() async {
  const url = Constants.PROFILE_GITHUB;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchlinklen() async {
  const url = Constants.PROFILE_LINKEDIN;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchinsta() async {
  const url = Constants.PROFILE_INSTAGRAM;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchfacebook() async {
  const url = Constants.PROFILE_FACEBOOK;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}