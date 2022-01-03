import 'package:flutter/material.dart';
import 'package:vlossom/Cards/albums_cards.dart';
import 'package:vlossom/Cards/artist.dart';
import 'package:vlossom/Pages/songs_list.dart';
import 'package:vlossom/Pages/minisongslist.dart';
import 'package:vlossom/Pages/models.dart';
import 'package:vlossom/Widgets/appdrawer.dart';
import 'package:vlossom/Widgets/carousel.dart';
import 'package:vlossom/Widgets/myappbar.dart';
import 'package:vlossom/bottomnavbar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vlossom/recordings/home.dart';

class HomePage extends StatefulWidget {
  // final String title;
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          useRootNavigator: false,
          useSafeArea: true,
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.mic),
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Recodinghome()));
              },
            ),
            // floatinz
            bottomNavigationBar: BottomNav(index: 0),
            extendBodyBehindAppBar: true,
            appBar: MyAppBar(
              title: 'Vlossom',
            ),
            // drawer: const AppDrawer(),
            body: Container(
                padding: EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff070919), Color(0xff191b29)])),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Mycarousel(),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: const Text(
                                      "New Albums",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "See all",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: const [
                                  AlbumCard(),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  AlbumCard(),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  AlbumCard(),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  AlbumCard(),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  AlbumCard(),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  AlbumCard(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: const Text(
                                      "Songs list",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SongsList()));
                                      },
                                      child: Text(
                                        "See all",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            MiniSongs(
                              song_length: 0,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: const Text(
                                      "Top Artist",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ArtistCard(),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ArtistCard(),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ArtistCard(),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ArtistCard(),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            )
                          ])),
                ))));
  }
}
