import 'package:flutter_application_1/data/api/repository_implementation/MovieRepository.dart';
import 'package:flutter_application_1/domain/repository_interface/model/Film.dart';

class MovieController {
  final MovieRepository repository;

  MovieController({required this.repository});

  Future<List<Film>> getMovies() async {
    List<Film> movies = await repository.getMovies();

    if (movies.isNotEmpty) {
      return movies;
    } else {
      return [];
    }
  }
}