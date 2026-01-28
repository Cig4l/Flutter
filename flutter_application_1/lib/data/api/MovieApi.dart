import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieApi {
  Future<List<Map<String, Object?>>> getMovies() async {
    final response = await http.get(
      Uri.parse('https://swapi.info/api/films/'),
    );

    final List films = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return films
        .map<Map<String, Object?>>(
          (movie) => Map<String, Object?>.from(movie),
        )
        .toList();
    } else {
      throw Exception('Api failed to load films');
    }
  }
}