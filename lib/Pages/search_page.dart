import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vlossom/Pages/models.dart';
import 'package:vlossom/Widgets/myappbar.dart';
import 'package:vlossom/Widgets/playing.dart';
import 'package:vlossom/Widgets/search_widget.dart';
import 'package:vlossom/classes/user_api.dart';
import 'package:vlossom/constant.dart';

class FilterNetworkListPage extends StatefulWidget {
  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<Post> songs = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final songs = await UserApi.fetchPosts(query);

    setState(() => this.songs = songs);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(title: "Disable"),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff070919), Color(0xff191b29)])),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Column(
            children: <Widget>[
              buildSearch(),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];

                    return buildsong(song);
                  },
                ),
              ),
            ],
          ),
        ),
      ));

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Song or Artist Name',
        onChanged: searchsong,
      );

  Future searchsong(String query) async => debounce(() async {
        final songs = await UserApi.fetchPosts(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.songs = songs;
        });
      });

  Widget buildsong(Post song) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Playing(
                      songs_name: song.name,
                      image: base_url + song.image,
                      artist_name: "artist_name",
                      song_url: base_url + song.audio,
                      id: song.id)));
        },

        title: Text(
          song.name,
          style: TextStyle(color: Colors.white),
        ),
        // subtitle: Text(song.artist),
      );
}
