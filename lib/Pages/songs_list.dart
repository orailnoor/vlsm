import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vlossom/Pages/minisongslist.dart';
import 'package:vlossom/Pages/models.dart';
import 'package:vlossom/Widgets/appdrawer.dart';
import 'package:vlossom/Widgets/myappbar.dart';
import 'package:vlossom/Widgets/playing.dart';
import 'package:vlossom/bottomnavbar.dart';

class SongsList extends StatefulWidget {
  const SongsList({Key? key}) : super(key: key);

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: MyAppBar(
              title: 'Songs',
            ),
            // drawer: const AppDrawer(),
            // bottomNavigationBar: BottomNav(index: 2),
            body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff070919), Color(0xff191b29)])),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: MiniSongs(song_length: 8),
                ))));
  }
}
