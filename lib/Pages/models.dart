// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.id,
    required this.name,
    required this.audio,
    required this.image,
    // required this.artist,
  });

  int id;
  String name;
  String audio;
  String image;
  // String artist;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: int.parse(json["id"]),
        name: json["name"],
        audio: json["audio"],
        image: json["image"],
        // artist: json["artist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "audio": audio,
        "image": image,
        // "artist": artist,
      };
}
