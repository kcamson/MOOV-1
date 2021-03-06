import 'dart:developer';
import 'dart:ui';

import 'package:MOOV/helpers/themes.dart';
import 'package:MOOV/models/going.dart';
import 'package:MOOV/models/going_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MOOV/services/database.dart';

import 'home.dart';

class OtherProfile extends StatefulWidget {
  String photoUrl, displayName, id, email, username;
  OtherProfile(this.photoUrl, this.displayName, this.id, this.email,
      this.username);

  @override
  State<StatefulWidget> createState() {
    return _OtherProfileState(this.photoUrl, this.displayName, this.id,
        this.email, this.username);
  }
}

class _OtherProfileState extends State<OtherProfile> {
  String photoUrl, displayName, id, email, username;
  final dbRef = Firestore.instance;
  _OtherProfileState(this.photoUrl, this.displayName, this.id,
      this.email, this.username);
  bool requestsent = false;
  bool sendRequest = false;
  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount userMe = googleSignIn.currentUser;
    final strUserId = userMe.id;
    final strPic = userMe.photoUrl;
    final strUserName = userMe.displayName;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 10),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: TextThemes.ndGold,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: TextThemes.ndBlue,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: TextThemes.ndBlue,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(photoUrl),
                      radius: 50,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                displayName,
                style: TextThemes.extraBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                email,
                style: TextThemes.subtitle1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '42 Friends',
                  style: TextThemes.bodyText1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text('•'),
                ),
                Text(
                  '2 upcoming MOOVS',
                  style: TextThemes.bodyText1,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child:


              RaisedButton(
                padding: const EdgeInsets.all(12.0),
                color:  Color.fromRGBO(2, 43, 91, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.0))),
                onPressed: () {
                  setState(() {
                    sendRequest = !sendRequest;
                    Database().sendFriendRequest(strUserId, id, strUserName, strPic);
                  });

                  setState(() => requestsent = !requestsent);
              //    Database().sendFriendRequest(strUserId, "115832884538005478119", "Developer Mind", "https://lh4.googleusercontent.com/-WU1Fg5u4Hmo/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclNL2hzvtuvNsFTWAHzUlpVyoos8Q/s96-c/photo.jpg");

                 // Navigator.pop(context);
                },
                child:  requestsent ? Text("Request Sent",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ): Text("Send Friend Request",style: new TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),),
              ),

            ),

          ],
        ),
      ),
    );
  }
}