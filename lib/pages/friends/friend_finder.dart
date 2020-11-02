import 'package:MOOV/utils/themes_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: TextThemes.ndBlue,
          //pinned: true,
          floating: false,
          expandedHeight: 30.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('FRIEND FINDER',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 100,
          delegate: SliverChildListDelegate([
            Container(
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: TextThemes.ndBlue,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/me.jpg'),
                          maxRadius: 32,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Kevin Camson is',
                          style: TextStyle(
                              fontSize: 16,
                              color: TextThemes.ndBlue,
                              decoration: TextDecoration.none)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 5),
                      child: Text('Going',
                          style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.activeGreen,
                              decoration: TextDecoration.none)),
                    ),
                    Text('to',
                        style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.black,
                            decoration: TextDecoration.none)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 0.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/chens.jpg',
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('J.W. Chens',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CupertinoColors.black,
                                    decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Container(
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: TextThemes.ndBlue,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/alvin.png'),
                          maxRadius: 32,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Alvin Alaphat is',
                          style: TextStyle(
                              fontSize: 16,
                              color: TextThemes.ndBlue,
                              decoration: TextDecoration.none)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 5),
                      child: Text('Going',
                          style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.activeGreen,
                              decoration: TextDecoration.none)),
                    ),
                    Text('to',
                        style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.black,
                            decoration: TextDecoration.none)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 2.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/motd.jpg',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8.0, right: 8.0),
                            child: Text('Hiking Trip',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CupertinoColors.black,
                                    decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                Container(
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: TextThemes.ndBlue,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/ingrid.png'),
                          maxRadius: 32,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Ingrid Vu is',
                          style: TextStyle(
                              fontSize: 16,
                              color: TextThemes.ndBlue,
                              decoration: TextDecoration.none)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 5),
                      child: Text('Going',
                          style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.activeGreen,
                              decoration: TextDecoration.none)),
                    ),
                    Text('to',
                        style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.black,
                            decoration: TextDecoration.none)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/kilwins.jpg',
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Ice Cream w/ AC",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CupertinoColors.black,
                                    decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ]),
        ),
      ],
    );
  }
}
