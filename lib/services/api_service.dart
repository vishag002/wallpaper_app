import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/api_model.dart';

class WallpaperService {
  // Method to fetch images with pagination support
  Future<List<MyClass>> getMyClass({int page = 1, int perPage = 30}) async {
    var client = http.Client();
    // Update the URL with page and per_page parameters
    var uri = Uri.parse(
        'https://api.unsplash.com/photos/?client_id=eAVunQXqeEpiTSwpCeYLfhse864BVP5qufx74IORWjI&page=$page&per_page=$perPage');
    try {
      var response = await client.get(uri);
      print("Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      if (response.statusCode == 200) {
        var json = response.body;
        print("Response Body: $json");
        var myClassList = myClassFromJson(json);
        print("Parsed MyClass List Length: ${myClassList.length}");
        return myClassList;
      } else {
        print("Error: ${response.reasonPhrase}");
        throw Exception("Failed to load images");
      }
    } catch (e) {
      print("Exception occurred: $e");
      throw Exception("Failed to load images");
    } finally {
      client.close();
    }
  }
}
