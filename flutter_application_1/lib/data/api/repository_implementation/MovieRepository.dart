import 'package:flutter_application_1/data/api/MovieApi.dart';
import 'package:flutter_application_1/domain/repository_interface/MovieRepositoryImpl.dart';
import 'package:flutter_application_1/domain/repository_interface/model/Film.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final movieApi = MovieApi();
  return MovieRepository(movieApi: movieApi); 
});


class MovieRepository implements MovieRepositoryImpl {
  final MovieApi movieApi;

  const MovieRepository({required this.movieApi});

  @override
  Future<List<Film>> getMovies() async {    // renvoie modèle
    final List<Map<String, Object?>> rawMovies = await this.movieApi.getMovies();

    return rawMovies
      .map((map) => Film.fromJson(map))
      .toList();
  }
}