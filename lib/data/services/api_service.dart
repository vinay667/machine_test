import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://dummyjson.com";

  Future<List<dynamic>> getUsers({
    required int skip,
    required int limit,
    String? gender,
  }) async {
    String url = "$baseUrl/users?limit=$limit&skip=$skip";

    if (gender != null) {
      url += "&key=gender&value=$gender";
    }

    print(url);

    final response = await http.get(Uri.parse(url));


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log(data.toString());
      return data['users'];
    } else {
      throw Exception("Failed to load users");
    }
  }
}
