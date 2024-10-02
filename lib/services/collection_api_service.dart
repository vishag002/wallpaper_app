import 'package:wallpaper_app/model/collection_api_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CollectionApiService {
  Future<List<CollectionClass>> getCollectionClass() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.unsplash.com/collections/?client_id=eAVunQXqeEpiTSwpCeYLfhse864BVP5qufx74IORWjI&page=1&per_page=40");
    try {
      var response = await client.get(uri);
      print("Collection Status code: ${response.statusCode}");
      print("X-Ratelimit-Limit: ${response.headers['x-ratelimit-limit']}");
      print(
          "X-Ratelimit-Remaining: ${response.headers['x-ratelimit-remaining']}");

      if (response.statusCode == 200) {
        var json = response.body;

        try {
          List<dynamic> jsonList = jsonDecode(json);
          List<CollectionClass> collectionClassList = [];

          for (var i = 0; i < jsonList.length; i++) {
            try {
              var collection = CollectionClass.fromJson(jsonList[i]);
              collectionClassList.add(collection);
            } catch (e) {
              print("Error parsing collection at index $i: $e");
              print("Problematic JSON: ${jsonEncode(jsonList[i])}");
            }
          }

          print(
              "Successfully parsed collection class list length: ${collectionClassList.length}");
          return collectionClassList;
        } catch (e) {
          print("Error decoding JSON: $e");
          print("Raw JSON: $json");
          throw Exception("Failed to decode JSON");
        }
      } else {
        print("Error: ${response.reasonPhrase}, Body: ${response.body}");
        throw Exception("Failed to load collections: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
      throw Exception("Failed to load collection: $e");
    } finally {
      client.close();
    }
  }
}
