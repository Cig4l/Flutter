import 'package:flutter_application_1/domain/repository_interface/model/Film.dart';

abstract class MovieRepositoryImpl {
  Future<List<Film>> getMovies();
}