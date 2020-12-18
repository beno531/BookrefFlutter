/*
import 'package:bookref/Models/bookref_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookrefApi {
  BookrefApi();

  Future<List<Data>> fetchBooks() async {
    final response =
        await http.get('https://bookref-api-dev.mi5u.de/api/books');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var parsedJson = json.decode(utf8.decode(response.bodyBytes));
      var tasks = Book.fromJson(parsedJson);
      return tasks.data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
*/
