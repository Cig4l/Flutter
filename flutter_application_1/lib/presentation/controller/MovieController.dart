import 'package:flutter_application_1/data/api/repository_implementation/MovieRepository.dart';
import 'package:flutter_application_1/domain/repository_interface/model/Film.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// movieController est une variable globale accessible partout dans l'application
final movieController = AsyncNotifierProvider.autoDispose<MovieController, List<Film>>(() {
  return MovieController();
});

// Pour le Controller, on utilise `AsyncNotifier` si on renvoie un Future, sinon `Notifier`.
class MovieController extends AsyncNotifier<List<Film>>{
  @override
  Future<List<Film>> build() async {
    final repository = ref.read(movieRepositoryProvider);
    return repository.getMovies();
  }
  // final MovieRepository repository;

  // MovieController({required this.repository});

  // Future<List<Film>> getMovies() async {
  //   List<Film> movies = await repository.getMovies();

  //   if (movies.isNotEmpty) {
  //     return movies;
  //   } else {
  //     return [];
  //   }
  // }
}