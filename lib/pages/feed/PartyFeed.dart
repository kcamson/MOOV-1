

import 'package:MOOV/pages/home/HomePage.dart';
///THESE "FEEDS" PROBABLY NEED TO BE CONSOLIDATED INTO ONE FILE THAT WORKS FOR ALL CATEGORIES


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MOOV/utils/themes_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PartyFeed extends StatefulWidget {
  PartyFeed({Key key}) : super(key: key);

  @override
  _PartyFeedState createState() => _PartyFeedState();
}

class _PartyFeedState extends State<PartyFeed> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        backgroundColor: TextThemes.ndBlue,
        //pinned: true,

        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/moovheader.png',
                fit: BoxFit.cover,
                height: 45.0,
              ),
              Image.asset(
                'lib/assets/ndlogo.png',
                fit: BoxFit.cover,
                height: 25,
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('food')
              .where("type", isEqualTo: "Party")
              .orderBy("startDate")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading data...');
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot course = snapshot.data.documents[index];
                return Card(
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Color(0xff000000),
                                        width: 1,
                                      )),
                                      child: Image.asset(
                                          'lib/assets/partybutton1.png',
                                          fit: BoxFit.cover,
                                          height: 130,
                                          width: 50)))),
                          Expanded(
                              child: Column(children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0)),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(course['title'].toString(),
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                course['description'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.all(5.0)),
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                      DateFormat('EEEE, MMM d, yyyy')
                                          .format(course['startDate'].toDate()),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold)),
                                )),
                          ]))
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.0),
                        child: Container(
                          height: 1.0,
                          width: 500.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              // Perform some action
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("WHO'S GOING?",
                                    style: TextStyle(
                                        color: Colors.blue[500],
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left)),
                          ),
                          FlatButton(
                            textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              // Perform some action
                            },
                            child: IconButton(
                              icon: (_isPressed)
                                  ? new Icon(Icons.favorite)
                                  : new Icon(Icons.favorite_border),
                              color: Colors.pink,
                              iconSize: 24.0,
                              splashColor: Colors.pink,
                              splashRadius: 7.0,
                              highlightColor: Colors.pink,
                              onPressed: () {
                                // Perform action
                                setState(() {
                                  if (_isPressed = true) {
                                    _isPressed = false;
                                  } else {
                                    _isPressed = true;
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
