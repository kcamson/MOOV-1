import 'package:MOOV/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MOOV/helpers/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:MOOV/pages/post_detail.dart';
import 'package:MOOV/services/database.dart';

import 'PostDepth.dart';

class MOOVSPage extends StatefulWidget {
  @override
  _MOOVSPageState createState() => _MOOVSPageState();
}

class _MOOVSPageState extends State<MOOVSPage> {
  final String currentUserId = currentUser?.id;
  bool isLiked = false;
  bool _isPressed;
  @override
  Widget build(BuildContext context) {
    isLiked = false;
    final GoogleSignInAccount user = googleSignIn.currentUser;
    final strUserId = user.id;
    final strUserName = user.displayName;
    final strUserPic = user.photoUrl;
    dynamic likeCount;

    if (likeCount == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: TextThemes.ndBlue,
          //pinned: true,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(5.0),
              icon: Icon(Icons.search),
              color: Colors.white,
              splashColor: Color.fromRGBO(220, 180, 57, 1.0),
              onPressed: () {
                // Implement navigation to shopping cart page here...
                print('Click Search');
              },
            ),
            IconButton(
              padding: EdgeInsets.all(5.0),
              icon: Icon(Icons.notifications_active),
              color: Colors.white,
              splashColor: Color.fromRGBO(220, 180, 57, 1.0),
              onPressed: () {
                // Implement navigation to shopping cart page here...
                print('Click Message');
              },
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(5),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/assets/moovblue.png',
                  fit: BoxFit.cover,
                  height: 55.0,
                ),
              ],
            ),
          ),
        ),
        body: Center(
            child: Text(
          "You have no MOOVs... Loser.",
          style: TextStyle(color: Colors.black),
        )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: TextThemes.ndBlue,
          //pinned: true,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(5.0),
              icon: Icon(Icons.search),
              color: Colors.white,
              splashColor: Color.fromRGBO(220, 180, 57, 1.0),
              onPressed: () {
                // Implement navigation to shopping cart page here...
                print('Click Search');
              },
            ),
            IconButton(
              padding: EdgeInsets.all(5.0),
              icon: Icon(Icons.notifications_active),
              color: Colors.white,
              splashColor: Color.fromRGBO(220, 180, 57, 1.0),
              onPressed: () {
                // Implement navigation to shopping cart page here...
                print('Click Message');
              },
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(5),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/assets/moovblue.png',
                  fit: BoxFit.cover,
                  height: 55.0,
                ),
              ],
            ),
          ),
        ),
// .where("liked", arrayContains: strUserId)
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('food')
                .where("liked", arrayContains: {
                  "strName": strUserName,
                  "strPic": strUserPic,
                  "uid": strUserId
                })
                .orderBy("startDate")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading data...');
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot course = snapshot.data.documents[index];
                  /*List<dynamic> likedArray = course["liked"];
                List<String> uidArray = List<String>();
                if (likedArray != null) {
                  likeCount = likedArray.length;
                  for (int i = 0; i < likeCount; i++){
                    var id = likedArray[i]["uid"];
                    uidArray.add(id);
                  }
                } else{
                  likeCount = 0;
                }

                if (uidArray != null) {
                  _isPressed = true;
                } else {
                  _isPressed = false;
                }*/
                  List<dynamic> likedArray = course["liked"];
                  if (likedArray != null) {
                    likeCount = likedArray.length;
                  } else {
                    likeCount = 0;
                  }
                  return Card(
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: new InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetail(
                                course['image'],
                                course['title'],
                                course['description'],
                                course['startDate'],
                                course['profilePic'],
                                course['userName'],
                                course['userEmail'],
                                likedArray,
                                course.documentID)));
                      },
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
                                        child: Image.network(course['image'],
                                            fit: BoxFit.cover,
                                            height: 130,
                                            width: 50),
                                      ))),
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
                                              .format(
                                                  course['startDate'].toDate()),
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
                          Container(
                              child: Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 4, 10),
                                  child: CircleAvatar(
                                    radius: 22.0,
                                    backgroundImage:
                                        NetworkImage(course['profilePic']),
                                    backgroundColor: Colors.transparent,
                                  )),
                              Container(
                                child: Column(
                                  //  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text(course['userName'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: TextThemes.ndBlue,
                                              decoration: TextDecoration.none)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text(course['userEmail'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: TextThemes.ndBlue,
                                              decoration: TextDecoration.none)),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: Column(
                                  //  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 6.0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                        ),
                                        color: Colors.pink,
                                        iconSize: 26.0,
                                        splashColor: Colors.pink,
                                        //splashRadius: 7.0,
                                        highlightColor: Colors.pink,
                                        onPressed: () async {
                                          // Perform action
                                          setState(() {
                                            final GoogleSignInAccount user =
                                                googleSignIn.currentUser;
                                            final strUserId = user.id;
                                            Database().removeLike(
                                                strUserId,
                                                course.documentID,
                                                strUserName,
                                                strUserPic);
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 24.0, 10),
                                      child: Text('$likeCount',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: TextThemes.ndBlue,
                                              decoration: TextDecoration.none)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          /*ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              // Perform some action
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDepth()),
                              );
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
                              icon: Icon(
                                Icons.favorite,
                              ),
                              color: Colors.pink,
                              iconSize: 24.0,
                              splashColor: Colors.pink,
                              splashRadius: 7.0,
                              highlightColor: Colors.pink,
                              onPressed: () async {
                                // Perform action
                                setState(() {
                                  final GoogleSignInAccount user = googleSignIn.currentUser;
                                  final strUserId = user.id;
                                  Database().removeLike(strUserId, course.documentID);
                                });
                              },
                            ),
                          ),
                        ],
                      ),*/
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
        // FloatingActionButton.extended(
        //     onPressed: () {
        //       // Add your onPressed code here!
        //     },
        //     label: Text('Find a MOOV',
        //         style: TextStyle(color: Colors.white)),
        //     icon: Icon(Icons.search, color: Colors.white),
        //     backgroundColor: Color.fromRGBO(220, 180, 57, 1.0))
      );
    }
  }

  handleLikePost() {
    if (isLiked == true) {
      isLiked = false;
    } else {
      isLiked = true;
    }
  }
}
