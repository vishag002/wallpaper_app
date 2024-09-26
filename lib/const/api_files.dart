class ApiConstants {
  static const String accessKey = 'eAVunQXqeEpiTSwpCeYLfhse864BVP5qufx74IORWjI';
  static const String secretKey = 'eA02nOiOphM8fHnzTQVRAhx1mVuZjjpDYeARmrT5D_0';
  static const String baseUrl = 'https://api.unsplash.com/photos/';

  // Constructed URL with the access key
  static String getPhotosUrl() {
    return '$baseUrl?client_id=$accessKey';
  }
}
