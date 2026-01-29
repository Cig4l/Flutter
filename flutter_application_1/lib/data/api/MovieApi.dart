import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final catApiProvider = Provider<MovieApi>((ref) {
  return MovieApi();
});

class MovieApi {    // renvoie data brute
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