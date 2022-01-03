import 'dart:convert';

import 'package:vlossom/Pages/models.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<Post>> fetchPosts(String query) async {
    http.Response response = await http
        .get(Uri.parse("https://leafcreations.in/vlossum_2/getsongs.php"));
    if (response.statusCode == 200) {
      print("200");
      // print(response.body);
      var responseJson = json.decode(response.body);
      // print(responseJson.toString());
      return (responseJson as List).map((p) => Post.fromJson(p)).where((song) {
        final songLower = song.name.toLowerCase();
        // final artistLower = song.image.toLowerCase();
        final searchLower = query.toLowerCase();

        return songLower.contains(searchLower);
        // artistLower.contains(searchLower);
      }).toList();
      // print(a)
    } else {
      throw Exception();
    }
  }
}
