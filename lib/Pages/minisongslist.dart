import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vlossom/Pages/models.dart';
import 'package:vlossom/Widgets/playing.dart';
import 'package:vlossom/constant.dart';

Future<List<Post>> fetchPosts() async {
  http.Response response = await http
      .get(Uri.parse("https://leafcreations.in/vlossum_2/getsongs.php"));
  if (response.statusCode == 200) {
    print("200");
    print(response.body);
  } else
    print("400");
  var responseJson = json.decode(response.body);
  print(responseJson.toString());
  return (responseJson as List).map((p) => Post.fromJson(p)).toList();
}

class MiniSongs extends StatefulWidget {
  int song_length = 0;
  // final int len = 4;

  MiniSongs({Key? key, required this.song_length}) : super(key: key);

  @override
  _MiniSongsState createState() => _MiniSongsState();
}

class _MiniSongsState extends State<MiniSongs> {
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // String base_url = "https://www.leafcreations.in/vlossum";

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      // color: Colors.orange,
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: fetchPosts(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Loading...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      // color: Colors.yellow,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          physics: widget.song_length == 0
                              ? NeverScrollableScrollPhysics()
                              : BouncingScrollPhysics(),
                          itemCount: widget.song_length == 0
                              ? 4
                              : snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: 80.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    // color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Playing(
                                                      songs_name: snapshot
                                                          .data[index].name,
                                                      image: base_url +
                                                          snapshot.data[index]
                                                              .image,
                                                      artist_name:
                                                          "artist_name",
                                                      song_url: base_url +
                                                          snapshot.data[index]
                                                              .audio,
                                                      id: snapshot
                                                          .data[index].id,
                                                    )));
                                      },
                                      child: Container(
                                        // color: Colors.red,
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.bottomLeft,
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          base_url +
                                                              snapshot
                                                                  .data[index]
                                                                  .image),
                                                      fit: BoxFit.cover),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      14, 0, 0, 20),
                                              child: Container(
                                                // color: Colors.black,
                                                child: Text(
                                                  snapshot.data[index].name,
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        color: Colors.white70,
                                        icon: new Icon(Icons.more_vert),
                                        tooltip: 'Navigation menu',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
