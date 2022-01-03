import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:vlossom/Widgets/myappbar.dart';
// import 'package:vlossom/Pages/models.dart';

class Playing extends StatefulWidget {
  final String songs_name;
  final String artist_name;
  final String image;
  final String song_url;
  final int id;

  Playing(
      {Key? key,
      required this.songs_name,
      required this.image,
      required this.id,
      required this.song_url,
      required this.artist_name})
      : super(key: key);

  @override
  _PlayingState createState() => _PlayingState();
}

class _PlayingState extends State<Playing> {
  var _icon = Icons.play_circle;

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    playAudioNetwork();
  }

  void playAudioNetwork() async {
    try {
      await audioPlayer.open(
        Audio.network(widget.song_url),
        showNotification: true,
      );
    } catch (t) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Song not availble"),
      ));
    }
  }
  // void setupPlaylist() async {
  //   audioPlayer.open(
  //       Playlist(audios: [
  //         Audio('assets/ava.mp3',
  //             metas: Metas(
  //                 title: 'All That',
  //                 artist: 'Benjamin Tissot',
  //                 image: MetasImage.asset('assets/allthat.jpg'))),
  //         Audio('assets/ava.mp3',
  //             metas: Metas(
  //                 title: 'Love',
  //                 artist: 'Benjamin Tissot',
  //                 image: MetasImage.asset('assets/love.jpg'))),
  //         Audio('assets/thejazzpiano.mp3',
  //             metas: Metas(
  //                 title: 'The Jazz Piano',
  //                 artist: 'Benjamin Tissot',
  //                 image: MetasImage.asset('assets/thejazzpiano.jpg'))),
  //       ]),
  //       autoStart: false,
  //       loopMode: LoopMode.playlist);
  // }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Widget linearProgressBar(Duration currentPosition, Duration duration) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: LinearPercentIndicator(
        width: 250,
        backgroundColor: Colors.grey,
        percent: currentPosition.inSeconds / duration.inSeconds,
        progressColor: Colors.white,
      ),
    );
  }

  Widget audioPlayerUI(RealtimePlayingInfos realtimePlayingInfos) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Text(
        //   realtimePlayingInfos.current.audio.audio.metas.title,
        //   style: TextStyle(color: Colors.white, fontSize: 25),
        // ),
        SizedBox(height: 10),
        // Text(realtimePlayingInfos.current.audio.audio.metas.artist,
        //     style: TextStyle(color: Colors.white, fontSize: 15)),
        // SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTimeText(realtimePlayingInfos.currentPosition),
            linearProgressBar(realtimePlayingInfos.currentPosition,
                realtimePlayingInfos.duration),
            getTimeText(realtimePlayingInfos.duration)
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.skip_previous_rounded),
                onPressed: () => audioPlayer.previous(),
                iconSize: 60,
                color: Colors.white),
            IconButton(
                icon: Icon(realtimePlayingInfos.isPlaying
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_circle_fill_rounded),
                onPressed: () => audioPlayer.playOrPause(),
                iconSize: 60,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.skip_next_rounded),
                onPressed: () => audioPlayer.next(),
                iconSize: 60,
                color: Colors.white),
          ],
        )
      ],
    );
  }

  Widget getTimeText(Duration seconds) {
    return Text(
      transformString(seconds.inSeconds),
      style: TextStyle(color: Colors.white),
    );
  }

  String transformString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(title: "Playing"),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff070919), Color(0xff191b29)])),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // SizedBox(
              //   height: 80,
              // ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 400,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(color: Colors.amber),
                child: Column(
                  children: [
                    Container(
                        height: 250,
                        width: 250,
                        child: Image.network(widget.image.toString())),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        widget.songs_name.toString(),
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   child: Text(
                    //     "Billie ",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: 360,
                // child: Lottie.network(
                //     "https://res.cloudinary.com/dytnlsq2h/raw/upload/v1638255244/lf30_editor_ysbbncsx.json")
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  // width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white10,
                  ),
                  // alignment: Alignment.center,
                  child: audioPlayer.builderRealtimePlayingInfos(
                      builder: (context, realtimePlayingInfos) {
                    if (realtimePlayingInfos != null) {
                      return audioPlayerUI(realtimePlayingInfos);
                    } else {
                      return Column();
                    }
                  }),
                ),
              ),
            ],
          )),
    );
  }
}
